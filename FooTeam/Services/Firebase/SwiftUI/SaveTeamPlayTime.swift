//
//  TeamPlayTime.swift
//  FooTeam
//
//  Created by Виталий Сосин on 19.10.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import Foundation
import Firebase

class SaveTeamPlayTime {
    
    static let shared = SaveTeamPlayTime()
    
    private let db = Firestore.firestore()
    
    
    // MARK: Сохраняем дату
    func saveDate(date: Date, idTeam: String, gameNumber: Int) {
        
        let teamTime = TeamTime(date: date)

        let refActionsPlayer = db.collection(["teams", idTeam, "dateAndTimeOfTheGame"].joined(separator: "/"))

        refActionsPlayer.document("игра-\(gameNumber)").setData(teamTime.representation) { (error) in }
    }
}
