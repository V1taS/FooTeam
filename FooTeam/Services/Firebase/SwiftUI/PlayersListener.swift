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
    
    @Published var players: [Players] = []
    
    init() {
        downloadPlayers()
    }
    
    func downloadPlayers() {
        FirebaseReference(.players).getDocuments { (snapshot, error) in
            guard let snapshot = snapshot else { return }
            if !snapshot.isEmpty {
                self.players = PlayersListener.playersFromDictionary(snapshot)
            }
        }
    }
    
    static func playersFromDictionary(_ snapshot: QuerySnapshot) -> [Players] {
        var players: [Players] = []
        
        for snapshot in snapshot.documents {
            let playerItem = Players(document: snapshot)
            players.append(playerItem!)
        }
        return players
    }
}
