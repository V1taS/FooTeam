//
//  PlayersListener.swift
//  FooTeam
//
//  Created by Виталий Сосин on 04.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import Foundation
import Firebase

class PlayersListener: ObservableObject {
    
    @Published var players: [Player] = []
    
    init() {
        downloadPlayers()
    }
    
    // MARK: Получаем всех игроков из БД
    func downloadPlayers() {
        FirebaseReference(.players).addSnapshotListener { (snapshot, error) in
            guard let snapshot = snapshot else { return }
            if !snapshot.isEmpty {
                self.players = PlayersListener.playersFromDictionary(snapshot)
            }
        }
    }
    
    static func playersFromDictionary(_ snapshot: QuerySnapshot) -> [Player] {
        var players: [Player] = []
        
        for snapshot in snapshot.documents {
            let playerItem = Player(document: snapshot)
            players.append(playerItem!)
        }
        return players
    }
}
