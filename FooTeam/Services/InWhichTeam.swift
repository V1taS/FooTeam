//
//  InWhichTeam.swift
//  FooTeam
//
//  Created by Виталий Сосин on 30.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import Foundation

class InWhichTeam {
    static let shared = InWhichTeam()
    
    func setNumberInWhichTeam(players: [Player], countNumbers: Int) {
        
        let sortedPlayers = players.sorted(by: { $0.rating > $1.rating })
        
        var team = 0
        
        for player in sortedPlayers {
            var player = player
            player.teamNumber = team
            
            EditPlayer.shared.editPlayerInTeam(player: player, players: players, name: nil, avatarImage: nil, email: nil, whoAreYou: nil, teamNumber: team, payment: nil, iGo: nil, subscription: nil, rating: nil, position: nil, numberOfGames: nil, numberOfGoals: nil, winGame: nil, losGame: nil, captain: nil)
            
            if team == countNumbers - 1 { team = 0 }
            team += 1
        }
        

    }
}
