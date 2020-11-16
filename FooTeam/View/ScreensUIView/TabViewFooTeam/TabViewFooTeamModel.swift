//
//  TabViewFooTeamModel.swift
//  FooTeam
//
//  Created by Виталий Сосин on 16.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI
import Combine
import FirebaseAuth
import Firebase

protocol TabViewFooTeamModelProtocol {
    var actionsPlayers: ActionsPlayers { get }
    var waitingPlayers: WaitingPlayers { get }
    var currentUser: CurrentUser { get }
    var cancellables: Set<AnyCancellable> { get }
    
    var showAcceptPlayers: Bool { get }
    var showTeamModal: Bool { get }
    var outFromTeam: Bool { get }
    
    var players: [Player] { get }
    var currentPlayer: Player { get }
    init()
}

class TabViewFooTeamModel: TabViewFooTeamModelProtocol, ObservableObject {
    @Published var actionsPlayers = ActionsPlayers()
    @Published var waitingPlayers = WaitingPlayers()
    @Published var currentUser = CurrentUser()
    internal var cancellables = Set<AnyCancellable>()
    
    @Published var showAcceptPlayers: Bool = false
    @Published var showTeamModal: Bool = false
    @Published var outFromTeam: Bool = false
    
    @Published var players: [Player] = []
    @Published var currentPlayer: Player = DefaultPlayer.shared.player
    
    required init() {
        self.currentUser.$player.sink { player in
            self.currentPlayer = player
            
            if FirestoreService.shared.currentUser.id == player.id {
                if player.idTeam.isEmpty {
                    self.outFromTeam = true
                }
            }
            
        } .store(in: &cancellables)
        
        self.waitingPlayers.$players.sink { players in
            self.players = players
            if !players.isEmpty {
                self.showAcceptPlayers = true
            }
        } .store(in: &cancellables)
    }
}
