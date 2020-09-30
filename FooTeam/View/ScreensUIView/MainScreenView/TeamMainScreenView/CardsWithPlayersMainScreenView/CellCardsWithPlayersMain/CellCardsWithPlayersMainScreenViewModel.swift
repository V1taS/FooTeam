//
//  CellCardsWithPlayersMainScreenViewModel.swift
//  FooTeam
//
//  Created by Виталий Сосин on 25.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI
import Combine

protocol CellCardsWithPlayersMainScreenViewModelProtocol {
    
}

class CellCardsWithPlayersMainScreenViewModel: CellCardsWithPlayersMainScreenViewModelProtocol, ObservableObject {
    
    @Published var actionsPlayers = ActionsPlayers()
    private var cancellables = Set<AnyCancellable>()
    
    @Published var teamsOne: [Player] = []
    @Published var teamsTwo: [Player] = []
    @Published var teamsThree: [Player] = []
    @Published var teamsFour: [Player] = []
    
    init() {
        self.actionsPlayers.$players.sink { playrs in
            let iGoPlayers = playrs.filter { $0.iGo }
            self.teamsOne = iGoPlayers.filter { $0.teamNumber == 0 }
            self.teamsTwo = iGoPlayers.filter { $0.teamNumber == 1 }
            self.teamsThree = iGoPlayers.filter { $0.teamNumber == 2 }
            self.teamsFour = iGoPlayers.filter { $0.teamNumber == 3 }
            
        }.store(in: &cancellables)
    }
}
