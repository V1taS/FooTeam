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
    func saveDate(date: Date, dayOfWeek: String, idTeam: String, gameNumber: Int, gameInWeak: Int, getPlayTime: [TeamTime]) {
        let refActionsPlayer = db.collection(["teams", idTeam, "dateAndTimeOfTheGame"].joined(separator: "/"))
        let teamTime = TeamTime(date: date, dayOfWeek: dayOfWeek, game: "game-\(gameNumber)")
        let curreentPlayTime = getPlayTime.filter { $0.game == "game-\(gameNumber)" }
        
        if gameInWeak + 1 <= getPlayTime.count {
            EditTeamPlayTime.shared.editDate(date: date, dayOfWeek: dayOfWeek, idTeam: idTeam, gameNumber: gameNumber, getPlayTime: curreentPlayTime)
        } else if gameNumber > getPlayTime.count {
            refActionsPlayer.document("game-\(gameNumber)").setData(teamTime.representation) { (error) in }
        }
        RemoveExcessTime.shared.removeTime(gameInWeak: gameInWeak, ref: refActionsPlayer)
    }
}
