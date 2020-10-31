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
    func saveDate(date: Date, dayOfWeek: String, idTeam: String, gameNumber: Int, arrayDateGame: [TeamTime], gameInWeak: Int) {
        
        let teamTime = TeamTime(date: date, dayOfWeek: dayOfWeek, game: "игра-\(gameNumber)")
        
        let refActionsPlayer = db.collection(["teams", idTeam, "dateAndTimeOfTheGame"].joined(separator: "/"))
        
        RemoveExcessTime.shared.removeTime(gameInWeak: gameInWeak, ref: refActionsPlayer)
        
        refActionsPlayer.document("игра-\(gameNumber)").setData(teamTime.representation) { (error) in }
        
//        for i in 0...gameInWeak {
//            refActionsPlayer.document("игра-\(i)").updateData(teamTime.representation) { (error) in }
//        }
        
    }
}
