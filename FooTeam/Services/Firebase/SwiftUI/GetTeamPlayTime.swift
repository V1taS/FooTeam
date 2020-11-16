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
            guard let snapshot = snapshot?.documents else { return }
            self.teams = snapshot.map { TeamTime(document: $0)! }
        }
    }
}


