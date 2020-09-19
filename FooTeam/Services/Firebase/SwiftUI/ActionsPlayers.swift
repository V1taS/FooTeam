//
//  WaitingPlayers.swift
//  FooTeam
//
//  Created by Виталий Сосин on 10.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import Foundation
import Firebase

class ActionsPlayers: ObservableObject {
    
    @Published var players: [Player] = []
    
    private let db = Firestore.firestore()
    
    init() {
        downloadPlayers()
    }
    
    // MARK: Получаем всех активных игроков текущей команды
    func downloadPlayers() {
        
        let currentPlayer = FirestoreService.shared.currentUser
        
        let refActionsPlayer = db.collection(["teams", currentPlayer!.idTeam, "actionsPlayers"].joined(separator: "/"))
        let usersRef = db.collection("players")
        
        refActionsPlayer.addSnapshotListener { (snapshot, error) in
            guard let snapshot = snapshot else { return }
            if !snapshot.isEmpty {
                for snapshot in snapshot.documents {
                    
                    let playerIDget = PlayersID(document: snapshot)
                    
                    usersRef.whereField("uid", isEqualTo: playerIDget!.id).addSnapshotListener() { (querySnapshot, err) in
                        
                        if let err = err {
                            print("Error getting documents: \(err)")
                        } else {
                            
                            for document in querySnapshot!.documents {
                                let playerNew = Player(document: document)
                                self.players.append(playerNew ?? Player(name: "", nameTeam: "", email: "", avatarStringURL: "", whoAreYou: "", id: "", idTeam: "", teamNumber: 0, payment: "", iGo: false, subscription: false, rating: 0, position: "", numberOfGames: 0, numberOfGoals: 0, winGame: 0, losGame: 0, captain: false))
                            }
                        }
                    }
                }
            }
        }
    }
}
