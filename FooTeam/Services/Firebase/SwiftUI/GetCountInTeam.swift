//
//  GetCountInTeam.swift
//  FooTeam
//
//  Created by Виталий Сосин on 02.11.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import Foundation
import Firebase

class GetCountInTeam: ObservableObject {
    
    @Published var players: [Player] = []
    
    private let db = Firestore.firestore()
    
    // MARK: Получаем всех активных игроков текущей команды
    func downloadPlayers(idTeam: String) {
            let refActionsPlayer = db.collection(["teams", idTeam, "actionsPlayers"].joined(separator: "/"))
            let usersRef = db.collection("players")
            
            refActionsPlayer.addSnapshotListener { (snapshot, error) in
                guard let snapshot = snapshot else { return }
                if !snapshot.isEmpty {
                    for snapshot in snapshot.documents {
                        
                        let playerIDget = PlayersID(document: snapshot)
                        
                        usersRef.whereField("uid", isEqualTo: playerIDget!.id).addSnapshotListener() { [self] (querySnapshot, err) in
                            
                            guard let snapshot = querySnapshot else { return }
                            
                            snapshot.documentChanges.forEach { (diff) in
                                guard let player = Player(document: diff.document) else { return }
                                switch diff.type {
                                case .added:
                                    guard !self.players.contains(player) else { return }
                                    self.players.append(player)
                                case .modified:
                                    guard let index = players.firstIndex(of: player) else { return }
                                    self.players[index] = player
                                    if player.idTeam.isEmpty {
                                        players.remove(at: index)
                                    }
                                case .removed:
                                    guard let index = players.firstIndex(of: player) else { return }
                                    players.remove(at: index)
                                }
                            }
                        }
                    }
                }
            }
        
    }
}

