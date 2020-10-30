//
//  GetTeamPlayTime.swift
//  FooTeam
//
//  Created by Виталий Сосин on 20.10.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import Foundation
import Firebase

class GetTeamPlayTime: ObservableObject {
    
    @Published var teams: [TeamTime] = []
    
    private let db = Firestore.firestore()
    
    init() {
        getIfoAboutTeam()
    }
    
    // MARK: Получаем всех активных игроков текущей команды
    func getIfoAboutTeam() {
            let refActionsPlayer = db.collection(["teams", FirestoreService.shared.currentUser.idTeam, "dateAndTimeOfTheGame"].joined(separator: "/"))
            
            refActionsPlayer.addSnapshotListener { (snapshot, error) in
                guard let snapshot = snapshot else { return }
                if !snapshot.isEmpty {
                    snapshot.documentChanges.forEach { (diff) in
                        guard let team = TeamTime(document: diff.document) else { return }
                        switch diff.type {
                        case .added:
                            self.teams.append(team)
                            print("get case .added:")
                        case .modified:
                            guard let index = self.teams.firstIndex(of: team) else { return }
                            self.teams.remove(at: index)
                            print("get case .modified:")
                        case .removed:
                            guard let index = self.teams.firstIndex(of: team) else { return }
                            self.teams.remove(at: index)
                            print("get case .removed:")
                        }
                    }
                }
            }
    }
}


