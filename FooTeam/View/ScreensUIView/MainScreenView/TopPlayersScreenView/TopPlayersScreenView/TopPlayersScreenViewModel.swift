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
    var playersMain: [Player] { get }
}

class TopPlayersScreenViewModel: TopPlayersScreenViewModelProtocol, ObservableObject {
    @Published var actionsPlayers = ActionsPlayers()
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published var playersMain: [Player] = []
    
    init() {
        self.actionsPlayers.$players.sink { players in
            let playersMain = players.filter { $0.subscription }
            
            self.playersMain = playersMain
            
        } .store(in: &cancellables)
    }
}

