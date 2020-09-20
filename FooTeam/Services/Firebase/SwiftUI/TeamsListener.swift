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
    
    private let db = Firestore.firestore()
    
    init() {
        downloadTeams()
    }
    
    func downloadTeams() {
        
        let teamsRef = db.collection("teams")
        
        teamsRef.addSnapshotListener() { [self] (querySnapshot, err) in
            
            guard let snapshot = querySnapshot else { return }
            
            snapshot.documentChanges.forEach { (diff) in
                guard let player = Teams(document: diff.document) else { return }
                switch diff.type {
                case .added:
                    guard !self.teams.contains(player) else { return }
                    self.teams.append(player)
                case .modified:
                    guard let index = teams.firstIndex(of: player) else { return }
                    self.teams[index] = player
                case .removed:
                    guard let index = teams.firstIndex(of: player) else { return }
                    teams.remove(at: index)
                }
            }
        }
    }
}
