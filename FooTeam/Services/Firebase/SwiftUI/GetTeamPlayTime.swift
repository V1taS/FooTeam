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
        if let currentPlayer = FirestoreService.shared.currentUser {
            
            let refActionsPlayer = db.collection(["teams", currentPlayer.idTeam, "dateAndTimeOfTheGame"].joined(separator: "/"))
            
            refActionsPlayer.addSnapshotListener { (snapshot, error) in
                guard let snapshot = snapshot else { return }
                if !snapshot.isEmpty {
                    for snapshot in snapshot.documents {
                        if let teamPlayTime = TeamTime(document: snapshot) {
                            self.teams.append(teamPlayTime)
                        }
                    }
                }
            }
        }
        
    }
}

