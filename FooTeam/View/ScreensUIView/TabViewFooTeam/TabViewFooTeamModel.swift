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
    var cancellables: Set<AnyCancellable> { get }
    
    var showAcceptPlayers: Bool { get }
    var players: [Player] { get }
    init()
}

class TabViewFooTeamModel: TabViewFooTeamModelProtocol, ObservableObject {
    @Published var actionsPlayers = ActionsPlayers()
    @Published var waitingPlayers = WaitingPlayers()
    @Published var currentUser = CurrentUser()
    internal var cancellables = Set<AnyCancellable>()
    
    @Published var showAcceptPlayers: Bool = false
    @Published var showTeamModal: Bool = false
    
    @Published var players: [Player] = []
    @Published var currentPlayer: Player = Player(name: "Default player", email: "", avatarStringURL: "", whoAreYou: "", id: "non", idTeam: "non", teamNumber: 0, payment: "", iGo: false, subscription: false, rating: 0, position: "", numberOfGoals: 0, winGame: 0, losGame: 9, captain: false)
    
    @Published var outFromTeam: Bool = false
    
    required init() {
        self.currentUser.$player.sink { player in
            self.currentPlayer = player
            
            if self.currentPlayer.idTeam.isEmpty {
                self.outFromTeam = true
            }
        } .store(in: &cancellables)
        
        //        if currentPlayer.idTeam.isEmpty {
        //            let mainContentFooTeam = UIHostingController(rootView: JoinToTeamView())
        //            mainContentFooTeam.modalPresentationStyle = .fullScreen
        //            UIApplication.shared.windows.first?.rootViewController = mainContentFooTeam
        //        }
        
        self.waitingPlayers.$players.sink { players in

            self.players = players
            if !players.isEmpty {
                self.showAcceptPlayers = true
            }
        } .store(in: &cancellables)
    }
}
