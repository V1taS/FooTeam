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
    @Published var teams: [Team] = []
    private let db = Firestore.firestore()
    
    init() {
        downloadTeams()
    }
    
    // MARK: Получаем все команды из БД
    func downloadTeams() {
        FirebaseReference(.teams).addSnapshotListener() { [self] (querySnapshot, err) in
            guard let snapshot = querySnapshot else { return }
            snapshot.documentChanges.forEach { (diff) in
                guard let team = Team(document: diff.document) else { return }
                switch diff.type {
                case .added:
                    guard !self.teams.contains(team) else { return }
                    self.teams.append(team)
                case .modified:
                    guard let index = teams.firstIndex(of: team) else { return }
                    self.teams[index] = team
                case .removed:
                    guard let index = teams.firstIndex(of: team) else { return }
                    teams.remove(at: index)
                }
            }
        }
    }
}
