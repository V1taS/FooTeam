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
    var waitingPlayers: WaitingPlayers { get }
    var cancellables: Set<AnyCancellable> { get }
    
    var currentTeam: CurrentTeam { get }
    var getTeamPlayTime: GetTeamPlayTime { get }
    var isPresentedEditTeam: Bool { get }
    var rating: Int { get }
    
    var players: [Player] { get }
    var team: Team { get }
    var getPlayTime: [TeamTime] { get }
    var playersWaitingAccept: [Player] { get }
    
    var teamType: String { get }
    var selectionAvailabilityTeamType: Int { get }
    
    var countPlayers: Int { get }
    var image: UIImage { get }
    init()
}

class TeamShowModalMainScreenViewModel: TeamShowModalMainScreenViewModelProtocol, ObservableObject {
    @Published var actionsPlayers = ActionsPlayers()
    @Published var waitingPlayers = WaitingPlayers()
    internal var cancellables = Set<AnyCancellable>()
    
    @Published var currentTeam = CurrentTeam()
    @Published var getTeamPlayTime = GetTeamPlayTime()
    @Published var isPresentedEditTeam: Bool = false
    @Published var rating: Int = 0
    
    @Published var players: [Player] = []
    @Published var team: Team = DefaultTeam.shared.team
    @Published var getPlayTime: [TeamTime] = []
    @Published var playersWaitingAccept: [Player] = []
    
    @Published var teamType = ""
    @Published var selectionAvailabilityTeamType: Int = 0
    
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
        
        self.currentTeam.$team.sink { [self] team in
            switch team.teamType {
            case "0":
                teamType = "Открытая"
            case "1":
                teamType = "Закрытая"
            default:
                teamType = "Error"
            }
            self.team = team
        } .store(in: &cancellables)
    }
}

