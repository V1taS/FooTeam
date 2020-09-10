//
//  TeamsListener.swift
//  FooTeam
//
//  Created by Виталий Сосин on 04.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import Foundation
import Firebase

class TeamsListener: ObservableObject {
    
    @Published var teams: [Teams] = []
    
    init() {
        downloadTeams()
    }
    
    func downloadTeams() {
        FirebaseReference(.teams).getDocuments { (snapshot, error) in
            guard let snapshot = snapshot else { return }
            if !snapshot.isEmpty {
                self.teams = TeamsListener.teamsFromDictionary(snapshot)
            }
        }
    }
    
    static func teamsFromDictionary(_ snapshot: QuerySnapshot) -> [Teams] {
        var players: [Teams] = []
        
        for snapshot in snapshot.documents {
            let playerItem = Teams(document: snapshot)
            players.append(playerItem!)
        }
        return players
    }
}
