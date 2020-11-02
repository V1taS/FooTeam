//
//  CellCardsWithPlayersMainScreenViewModel.swift
//  FooTeam
//
//  Created by Виталий Сосин on 25.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import Foundation
import Combine

protocol CellCardsWithPlayersMainScreenViewModelProtocol {
    var currentTeam: CurrentTeam { get }
    var actionsPlayers: ActionsPlayers { get }
    var cancellables: Set<AnyCancellable> { get }
    
    var iGoPlayers: [Player] { get }
    var team: Team { get}
    init()
}

class CellCardsWithPlayersMainScreenViewModel: CellCardsWithPlayersMainScreenViewModelProtocol, ObservableObject {
    @Published var currentTeam = CurrentTeam()
    @Published var actionsPlayers = ActionsPlayers()
    internal var cancellables = Set<AnyCancellable>()
    
    @Published var iGoPlayers: [Player] = []
    @Published var team: Team = Team(
        avatarStringURL: "",
        teamName: "",
        location: "",
        teamType: "",
        rating: 0,
        maxCountPlayersInTeam: 18,
        isHidden: true,
        currentCountPlayersInTeam: 18
    )

    required init() {
        self.actionsPlayers.$players.sink { players in
            let iGoPlayers = players.filter { $0.iGo }
            self.iGoPlayers = iGoPlayers
            
        }.store(in: &cancellables)
        
        self.currentTeam.$team.sink { team in
            self.team = team
        } .store(in: &cancellables)
    }
}
