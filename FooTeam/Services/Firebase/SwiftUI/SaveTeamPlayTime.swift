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
    func saveDate(date: Date, dayOfWeek: String, idTeam: String, gameNumber: Int, arrayDateGame: [TeamTime]) {
        var arrayDateGame = arrayDateGame
        
        let teamTime = TeamTime(date: date, dayOfWeek: dayOfWeek)

        let refActionsPlayer = db.collection(["teams", idTeam, "dateAndTimeOfTheGame"].joined(separator: "/"))

//        refActionsPlayer.document("игра-\(gameNumber)").setData(teamTime.representation) { (error) in }
        
        refActionsPlayer.addSnapshotListener { (querySnapshot, error) in
            guard let snapshot = querySnapshot else { return }
            
            snapshot.documentChanges.forEach { (diff) in
                guard let date = TeamTime(document: diff.document) else { return }
                switch diff.type {
                case .added:
                    guard !arrayDateGame.contains(date) else { return }
                    arrayDateGame.append(date)
                case .modified:
                    guard let index = arrayDateGame.firstIndex(of: date) else { return }
                    arrayDateGame[index] = date
                case .removed:
                    guard let index = arrayDateGame.firstIndex(of: date) else { return }
                    arrayDateGame.remove(at: index)
                }
            }
        }
        
        refActionsPlayer.document("игра-\(gameNumber)").setData(teamTime.representation) { (error) in }
    }
}
