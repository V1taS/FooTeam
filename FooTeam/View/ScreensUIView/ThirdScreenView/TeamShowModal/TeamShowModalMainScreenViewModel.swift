//
//  TeamShowModalMainScreenViewModel.swift
//  FooTeam
//
//  Created by Виталий Сосин on 08.10.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI
import Combine

protocol TeamShowModalMainScreenViewModelProtocol {
    var actionsPlayers: ActionsPlayers { get }
    var currentTeam: CurrentTeam { get }
    var cancellables: Set<AnyCancellable> { get }
    
    var isPresentedEditTeam: Bool { get }
    
    var players: [Player] { get }
    var team: Team { get }
    var rating: Int { get }
    
    var availabilityTeamType: [String] { get }
    var selectionAvailabilityTeamType: Int { get }
    
    var image: UIImage { get }
    var countPlayers: Int { get }
    init()
}

class TeamShowModalMainScreenViewModel: TeamShowModalMainScreenViewModelProtocol, ObservableObject {
    
    @Published var waitingPlayers = WaitingPlayers()
    @Published var actionsPlayers = ActionsPlayers()
    @Published var getTeamPlayTime = GetTeamPlayTime()
    @Published var currentTeam = CurrentTeam()
    internal var cancellables = Set<AnyCancellable>()
    
    @Published var isPresentedEditTeam: Bool = false
    @Published var rating: Int = 0
    
    @Published var players: [Player] = []
    
    @Published var team: Team = Team(
        avatarStringURL: "",
        teamName: "",
        location: "",
        teamType: "",
        rating: 0,
        maxCountPlayersInTeam: 18,
        isHidden: false,
        currentCountPlayersInTeam: 18,
        country: "",
        totalMoney: "",
        gameСosts: "",
        fieldType: ""
    )
    
    @Published var getPlayTime: [TeamTime] = []
    @Published var playersWaitingAccept: [Player] = []
    
    var availabilityTeamType: [String] = ["Открытая", "Закрытая"] // Настроить логику
    @Published var selectionAvailabilityTeamType: Int = 0 // Настроить логику
    
    @Published var countPlayers: Int = 0
    
    @Published var image = UIImage()
    
    
    required init() {
        self.waitingPlayers.$players.sink { players in
            self.playersWaitingAccept = players
        } .store(in: &cancellables)
        
        self.getTeamPlayTime.$teams.sink { dates in
            self.getPlayTime = dates
            } .store(in: &cancellables)
        
        
        self.actionsPlayers.$players.sink { players in
            var totalRating = 1
            let playersRating = players.filter { $0.winGame > 1 || $0.losGame > 1 }
            playersRating.forEach { player in totalRating += player.rating }
            if !playersRating.isEmpty { self.rating = totalRating / playersRating.count }
            self.players = players
        } .store(in: &cancellables)
        
        self.currentTeam.$team.sink { team in
            self.team = team
        } .store(in: &cancellables)
    }
}

