//
//  WaitingForConfirmationViewModel.swift
//  FooTeam
//
//  Created by Виталий Сосин on 25.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import Combine
import FirebaseAuth

protocol WaitingForConfirmationViewModelProtocol {
    
}

class WaitingForConfirmationViewModel: WaitingForConfirmationViewModelProtocol, ObservableObject {
    
    @Published var currentUser = CurrentUser()
//    @Published var actionsPlayers = ActionsPlayers()
    private var cancellables = Set<AnyCancellable>()
    
    @Published var downloadAmount: Double = 0.0
    @Published var isPresented: Bool = false
    
    @Published var player: Player = Player(name: "Default player", email: "", avatarStringURL: "", whoAreYou: "", id: "", idTeam: "", teamNumber: 0, payment: "", iGo: false, subscription: false, rating: 0, position: "", numberOfGames: 0, numberOfGoals: 0, winGame: 0, losGame: 9, captain: false)
//    @Published var players: [Player] = []
    
    init() {
        self.currentUser.$player.sink { player in
            self.player = player
        } .store(in: &cancellables)
        
        print("waiting экран - \(self.player)")
        
//        self.actionsPlayers.$players.sink { players in
//            self.players = players
//        } .store(in: &cancellables)
//        
//        if self.players.contains(self.player) {
//            isPresented = true
//        }
    }
}
