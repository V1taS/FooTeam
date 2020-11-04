//
//  TopPlayersScreenViewModel.swift
//  FooTeam
//
//  Created by Виталий Сосин on 21.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import Foundation
import Combine

protocol TopPlayersScreenViewModelProtocol {
    var actionsPlayers: ActionsPlayers { get }
    var currentTeam: CurrentTeam { get }
    var cancellables: Set<AnyCancellable> { get }
    
    var players: [Player] { get }
    var team: Team { get }
    init()
}

class TopPlayersScreenViewModel: TopPlayersScreenViewModelProtocol, ObservableObject {
    @Published var actionsPlayers = ActionsPlayers()
    @Published var currentTeam = CurrentTeam()
    internal var cancellables = Set<AnyCancellable>()
    
    @Published var players: [Player] = []
    @Published var team: Team = Team(
        avatarStringURL: "",
        teamName: "",
        location: "",
        teamType: "",
        rating: 0,
        maxCountPlayersInTeam: 18,
        isHidden: true,
        currentCountPlayersInTeam: 18,
        country: "",
        totalMoney: "",
        gameСosts: "",
        fieldType: ""
    )
    
    required init() {
        self.actionsPlayers.$players.sink { players in
            let playersTOP = players.filter { $0.rating > 89 }
            self.players = playersTOP.sorted(by: { $0.rating > $1.rating })
        } .store(in: &cancellables)
        
        self.currentTeam.$team.sink { team in
            self.team = team
        } .store(in: &cancellables)
    }
}

