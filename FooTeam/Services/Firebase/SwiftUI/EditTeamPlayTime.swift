//
//  EditTeamPlayTime.swift
//  FooTeam
//
//  Created by Виталий Сосин on 02.11.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import Foundation
import Firebase

class EditTeamPlayTime {
    
    static let shared = EditTeamPlayTime()
    
    private let db = Firestore.firestore()
    
    
    // MARK: редактируем дату
    func editDate(date: Date, dayOfWeek: String, idTeam: String, gameNumber: Int, getPlayTime: [TeamTime]) {
        
        let refActionsPlayer = db.collection(["teams", idTeam, "dateAndTimeOfTheGame"].joined(separator: "/"))
        
        for playTime in getPlayTime {
            var playTime = playTime
            playTime.date = date
            playTime.dayOfWeek = dayOfWeek
            playTime.game = "игра-\(gameNumber)"
            refActionsPlayer.document("игра-\(gameNumber)").updateData(playTime.representation) { (error) in }
        } 
    }
}
