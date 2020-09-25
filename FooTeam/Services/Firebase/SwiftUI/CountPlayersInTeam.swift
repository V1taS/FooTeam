//
//  CountPlayersInTeam.swift
//  FooTeam
//
//  Created by Виталий Сосин on 14.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import Foundation
import Firebase

class CountPlayersInTeam {
    
    static let shared = CountPlayersInTeam()
    
    var players: [Player] = []
    
    private let db = Firestore.firestore()
    
    // MARK: Получаем всех активных игроков текущей команды
    func downloadPlayers(currentTeam: Team) {
        
        let refActionsPlayer = db.collection(["teams", currentTeam.id, "actionsPlayers"].joined(separator: "/"))
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
                            
                            querySnapshot!.documentChanges.forEach { (diff) in
                                guard let player = Player(document: diff.document) else { return }
                                self.players.append(player)
                            }
                        }
                    }
                }
            }
        }
    }
}

