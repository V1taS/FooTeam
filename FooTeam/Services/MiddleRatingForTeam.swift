//
//  MiddleRatingForTeam.swift
//  FooTeam
//
//  Created by Виталий Сосин on 04.11.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import Foundation

class MiddleRatingForTeam {
    static let shared = MiddleRatingForTeam()
    
    func setMiddleRatingForTeam(players: [Player], teamNumber: Int) -> Int {
        
        var totalRating = 1
        
        let playersRating = players.filter { $0.teamNumber == teamNumber }
        
        playersRating.forEach { player in totalRating += player.rating }
        
        if !playersRating.isEmpty {
            return totalRating / playersRating.count
        }
        return 0
    }
}

