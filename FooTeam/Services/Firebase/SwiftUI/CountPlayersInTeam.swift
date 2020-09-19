//
//  CountPlayersInTeam.swift
//  FooTeam
//
//  Created by Виталий Сосин on 14.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import Foundation
import Firebase

class CountPlayersInTeam: ObservableObject {
    
    @Published var players: [Player] = []
    
    private let db = Firestore.firestore()
    
    // MARK: Получаем всех активных игроков текущей команды
    func downloadPlayers(playersActions: [Player], team: Teams) {
        
        let refActionsPlayer = db.collection(["teams", team.id, "actionsPlayers"].joined(separator: "/"))
        let usersRef = db.collection("players")
        
        refActionsPlayer.addSnapshotListener { (snapshot, error) in
            guard let snapshot = snapshot else { return }
            if !snapshot.isEmpty {
                for snapshot in snapshot.documents {
                    
                    let playerIDget = PlayersID(document: snapshot)
                    usersRef.whereField("uid", isEqualTo:
                        playerIDget!.id).addSnapshotListener() { (querySnapshot, err) in
                        
                        if let err = err {
                            print("Error getting documents: \(err)")
                        } else {
                            
                            querySnapshot!.documentChanges.forEach { (diff) in
                                guard let player = Player(document: diff.document) else { return }
                                switch diff.type {
                                case .added:
                                    guard !playersActions.contains(player) else { return }
                                    self.players.append(player)
                                case .modified:
                                    guard let index = self.players.firstIndex(of: player) else { return }
                                    self.players[index] = player
                                case .removed:
                                    guard let index = self.players.firstIndex(of: player) else { return }
                                    self.players.remove(at: index)
                                }
                            }
                            
                            
                            
                            
//
//                            for document in querySnapshot!.documents {
//                                let playerNew = Players(document: document)
//                                self.players.append(playerNew!)
//                            }
                        }
                    }
                }
            }
        }
    }
}

