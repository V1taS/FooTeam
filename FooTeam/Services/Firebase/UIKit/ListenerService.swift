//
//  ListenerService.swift
//  FooTeam
//
//  Created by Виталий Сосин on 18.07.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI
import FirebaseAuth
import Firebase

class ListenerService {
    
    static let shared = ListenerService()

    private let db = Firestore.firestore()
    
    private var usersRef: CollectionReference {
        return db.collection("players")
    }
    
    private var currentUserId: String {
        return Auth.auth().currentUser!.uid
    }
    
    
    func playersObserve(players: [Players], completion: @escaping (Result<[Players], Error>) -> Void) -> ListenerRegistration? {
        var players = players
        let usersListener = usersRef.addSnapshotListener { (querySnapshot, error) in
            guard let snapshot = querySnapshot else {
                completion(.failure(error!))
                return
            }
            snapshot.documentChanges.forEach { (diff) in
                guard let player = Players(document: diff.document) else { return }
                switch diff.type {
                case .added:
                    guard !players.contains(player) else { return }
                    guard player.id != self.currentUserId else { return }
                    players.append(player)
                case .modified:
                    guard let index = players.firstIndex(of: player) else { return }
                    players[index] = player
                case .removed:
                    guard let index = players.firstIndex(of: player) else { return }
                    players.remove(at: index)
                }
            }
            completion(.success(players))
        }
        return usersListener
    } // usersObserve
    
    
    func waitingPlayersObserve(player: [Players], completion: @escaping (Result<[Players], Error>) -> Void) -> ListenerRegistration? {
        var player = player
        let waitingPlayer = db.collection(["players", currentUserId, "waitingTeams"].joined(separator: "/"))
        let playerListener = waitingPlayer.addSnapshotListener { (querySnapshot, error) in
            guard let snapshot = querySnapshot else {
                completion(.failure(error!))
                return
            }
            
            snapshot.documentChanges.forEach { (diff) in
                guard let waitingPlayer = Players(document: diff.document) else { return }
                switch diff.type {
                case .added:
                    guard !player.contains(waitingPlayer) else { return }
                    player.append(waitingPlayer)
                case .modified:
                    guard let index = player.firstIndex(of: waitingPlayer) else { return }
                    player[index] = waitingPlayer
                case .removed:
                    guard let index = player.firstIndex(of: waitingPlayer) else { return }
                    player.remove(at: index)
                }
            }
            
            completion(.success(player))
        }
        
        return playerListener
    }
}
