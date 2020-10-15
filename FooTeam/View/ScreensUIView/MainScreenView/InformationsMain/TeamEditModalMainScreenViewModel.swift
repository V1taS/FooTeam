//
//  TeamEditModalMainScreenViewModel.swift
//  FooTeam
//
//  Created by Виталий Сосин on 09.10.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI
import Combine

protocol TeamEditModalMainScreenViewModelProtocol {
    var actionsPlayers: ActionsPlayers { get }
    var currentTeam: CurrentTeam { get }
    var cancellables: Set<AnyCancellable> { get }
    
    var isPresentedChangeAvatar: Bool { get }
    
    var players: [Player] { get }
    var team: Team { get }
    var deleteTeam: Bool { get }
    var calendarDetails: Date { get }
    
    var availabilityTeamType: [String] { get }
    var selectionAvailabilityTeamType: Int { get }

    var image: UIImage { get }
    init()
}

class TeamEditModalMainScreenViewModel: TeamEditModalMainScreenViewModelProtocol, ObservableObject {
    @Published var actionsPlayers = ActionsPlayers()
    @Published var currentTeam = CurrentTeam()
    internal var cancellables = Set<AnyCancellable>()
    
    @Published var isPresentedChangeAvatar: Bool = false
    @Published var deleteTeam: Bool = false
    @Published var calendarDetails = Date()
    
    @Published var players: [Player] = []

    @Published var team: Team = Team(
        avatarStringURL: "",
        teamName: "",
        location: "",
        teamType: "",
        rating: 0
    )
    
    var availabilityTeamType: [String] = ["Открытая", "Закрытая"]
    @Published var selectionAvailabilityTeamType: Int = 0

    @Published var image = UIImage()
    
    required init() {
        self.actionsPlayers.$players.sink { players in
            self.players = players
        } .store(in: &cancellables)
        
        self.currentTeam.$team.sink { team in
            switch team.teamType {
            case "Открытая":
                self.selectionAvailabilityTeamType = 0
            case "Закрытая":
                self.selectionAvailabilityTeamType = 1
            default:
                self.selectionAvailabilityTeamType = 0
            }
            self.team = team
        } .store(in: &cancellables)
    }
}


