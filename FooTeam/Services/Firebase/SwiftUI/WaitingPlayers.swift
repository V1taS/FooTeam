//
//  WaitingPlayers.swift
//  FooTeam
//
//  Created by Виталий Сосин on 11.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import Foundation
import Firebase

class WaitingPlayers: ObservableObject {
    
    @Published var players: [Players] = []
    
    private let db = Firestore.firestore()
    
    init() {
        downloadPlayers()
    }
    
    func downloadPlayers() {
        
        let currentPlayer = FirestoreService.shared.currentUser
        
        guard currentPlayer?.captain == true else { return }
        
        let refActionsPlayer = db.collection(["teams", currentPlayer!.idTeam, "waitingPlayers"].joined(separator: "/"))
        let usersRef = db.collection("players")
        
        refActionsPlayer.getDocuments { (snapshot, error) in
            guard let snapshot = snapshot else { return }
            if !snapshot.isEmpty {
                for snapshot in snapshot.documents {
                    
                    let playerIDget = PlayersID(document: snapshot)
                    
                    usersRef.whereField("uid", isEqualTo: playerIDget!.id).getDocuments() { (querySnapshot, err) in
                        
                        if let err = err {
                            print("Error getting documents: \(err)")
                        } else {
                            
                            for document in querySnapshot!.documents {
                                let playerNew = Players(document: document)
                                self.players.append(playerNew!)
                            }
                        }
                    }
                }
            }
        }
    }
}

