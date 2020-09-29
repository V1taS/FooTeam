//
//  TabViewFooTeamModel.swift
//  FooTeam
//
//  Created by Виталий Сосин on 16.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI
import Combine

protocol TabViewFooTeamModelProtocol {
    
    
}

class TabViewFooTeamModel: TabViewFooTeamModelProtocol, ObservableObject {
    
    @Published var waitingPlayers = WaitingPlayers()
    
    private var cancellables = Set<AnyCancellable>()
    
    
    @Published var viewState: CGSize = CGSize.zero
    @Published var showAcceptPlayers: Bool = false
    @Published var players: [Player] = [] {
        didSet {
            if !players.isEmpty {
                self.showAcceptPlayers = true
            }
        }
    }
    
    init() {
        self.waitingPlayers.$players.sink { players in
            self.players = players
        }
        .store(in: &cancellables)
    }
}
