//
//  ListTeamsMainScreenViewModel.swift
//  FooTeam
//
//  Created by Виталий Сосин on 16.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import Foundation
import Combine

protocol ListTeamsMainScreenViewModelProtocol {
    var actionsPlayers: ActionsPlayers { get }
    var currentTeam: CurrentTeam { get }
    var cancellables: Set<AnyCancellable> { get }
    
    var iGoCount: Int { get }
    var countTeams: Int { get }
    var selectionTeams: Int { get }
    var iGoPlayers: [Player] { get }
    var team: Team { get }
    init()
}

class ListTeamsMainScreenViewModel: ListTeamsMainScreenViewModelProtocol, ObservableObject {
    @Published var actionsPlayers = ActionsPlayers()
    @Published var currentTeam = CurrentTeam()
    internal var cancellables = Set<AnyCancellable>()
    
    @Published var iGoCount: Int = 0 
    @Published var countTeams: Int = 0
    @Published var selectionTeams: Int = 0
    @Published var iGoPlayers: [Player] = []
    @Published var team: Team = DefaultTeam.shared.team
    
    required init() {
        self.currentTeam.$team.sink { team in
            self.team = team
        } .store(in: &cancellables)
        
        self.actionsPlayers.$players.sink { players in
            let iGoPlayers = players.filter { $0.iGo }
            self.iGoPlayers = iGoPlayers
            self.iGoCount = iGoPlayers.count
        } .store(in: &cancellables)
    }
}
