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
    
    @Published var players: [Player] = []
    
    private let db = Firestore.firestore()
    
    init() {
        downloadPlayers()
    }
    
    // MARK: Получаем всех ОЖИДАЮЩИХ ПОДТВЕРЖДЕНИЯ игроков текущей команды
    func downloadPlayers() {
        
        if let currentPlayer = FirestoreService.shared.currentUser {
            
            let refWaitingPlayers = db.collection(["teams", currentPlayer.idTeam, "waitingPlayers"].joined(separator: "/"))
            let usersRef = db.collection("players")
            
            refWaitingPlayers.addSnapshotListener { (snapshot, error) in
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
}

