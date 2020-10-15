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
    init()
}

class TeamShowModalMainScreenViewModel: TeamShowModalMainScreenViewModelProtocol, ObservableObject {
    @Published var actionsPlayers = ActionsPlayers()
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
        rating: 0
    )
    
    var availabilityTeamType: [String] = ["Открытая", "Закрытая"] // Настроить логику
    @Published var selectionAvailabilityTeamType: Int = 0 // Настроить логику

    @Published var image = UIImage()
    
    required init() {
        self.actionsPlayers.$players.sink { players in
            var totalRating = 1
            players.forEach { player in totalRating += player.rating }
            if !players.isEmpty { self.rating = totalRating / players.count }
            self.players = players
        } .store(in: &cancellables)
        
        self.currentTeam.$team.sink { team in
            self.team = team
        } .store(in: &cancellables)
    }
}

