//
//  RatingOfPlayers.swift
//  FooTeam
//
//  Created by Виталий Сосин on 25.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import Foundation

class RatingOfPlayers {
    
    static let shared = RatingOfPlayers()
    
    func setRating(players: [Player]) {
        
        let actionPlayers = players.filter { $0.position != "ВРТ"}
        let goalkeeper = players.filter { $0.position == "ВРТ"}
        
        for player in actionPlayers {
            var player = player
            
            let win = player.winGame
            let los = player.losGame
            let game = win + los
            let goal = player.numberOfGoals
            
            var totalRating = 50
            
            if win != 0 && los != 0 && game != 0 && goal != 0 {
                // Победы. Находим процент побед от общего количества игр (до 80)
                switch win / game * 100 {
                case 0...25:
                    print("Райтинг: 65")
                    totalRating = 65
                case 26...50:
                    print("Райтинг: 70")
                    totalRating = 70
                case 51...75:
                    print("Райтинг: 75")
                    totalRating = 75
                case 76...100:
                    print("Райтинг: 80")
                    totalRating = 80
                default:
                    print("Превышение лимита")
                }
                
                // Забитые голы. Находим процент от количества игр и забитых мячей (до 19)
                switch goal / game * 100 {
                case 0...25:
                    print("Райтинг: 9")
                    totalRating += 9
                case 26...50:
                    print("Райтинг: 13")
                    totalRating += 13
                case 51...75:
                    print("Райтинг: 14")
                    totalRating += 14
                case 76...100:
                    print("Райтинг: 16")
                    totalRating += 16
                default:
                    print("Райтинг: 19")
                    totalRating += 19
                }
                player.rating = totalRating
            }

            EditPlayer.shared.editPlayerInTeam(player: player, players: players, name: nil, avatarImage: nil, email: nil, whoAreYou: nil, teamNumber: nil, payment: nil, iGo: nil, subscription: nil, rating: totalRating, position: nil, numberOfGames: nil, numberOfGoals: nil, winGame: nil, losGame: nil, captain: nil)
        }
        
        for player in goalkeeper {
            var player = player
            
            let win = player.winGame
            let los = player.losGame
            let game = win + los
            
            var totalRating = 50
            
            if win != 0 && los != 0 && game != 0 {
                // Рейтинг у вратаря. Находим процент от выйгранных игр. (до 99)
                switch win / game * 100 {
                case 0...25:
                    print("Вратарский райтинг: 78")
                    totalRating = 78
                case 26...50:
                    print("Вратарский райтинг: 89")
                    totalRating = 89
                case 51...75:
                    print("Вратарский райтинг: 95")
                    totalRating = 95
                case 76...100:
                    print("Вратарский райтинг: 99")
                    totalRating = 99
                default:
                    print("Превышение лимита")
                }
                
                player.rating = totalRating
            }
            EditPlayer.shared.editPlayerInTeam(player: player, players: players, name: nil, avatarImage: nil, email: nil, whoAreYou: nil, teamNumber: nil, payment: nil, iGo: nil, subscription: nil, rating: totalRating, position: nil, numberOfGames: nil, numberOfGoals: nil, winGame: nil, losGame: nil, captain: nil)
            
        }
    }
}
