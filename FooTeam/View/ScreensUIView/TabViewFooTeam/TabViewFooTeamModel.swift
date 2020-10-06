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
    var waitingPlayers: WaitingPlayers { get }
    var cancellables: Set<AnyCancellable> { get }
    
    var showAcceptPlayers: Bool { get }
    var players: [Player] { get }
    init()
}

class TabViewFooTeamModel: TabViewFooTeamModelProtocol, ObservableObject {
    @Published var waitingPlayers = WaitingPlayers()
    internal var cancellables = Set<AnyCancellable>()
    
    @Published var showAcceptPlayers: Bool = false
    @Published var players: [Player] = []
    
    required init() {
        self.waitingPlayers.$players.sink { players in
            self.players = players
            
            if !players.isEmpty {
                self.showAcceptPlayers = true
            }
        }
        .store(in: &cancellables)
    }
}
