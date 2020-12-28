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
    
    func setRating(position: String, winGame: Int, losGame: Int, numberOfGoals: Int) -> Int {
        
        if position == "0" {
            var winGame = winGame
            let game = winGame + losGame
            var totalRating = 50
            var numberOfGoals = numberOfGoals
            if numberOfGoals == 0 { numberOfGoals = 1 }
            if winGame == 0 { winGame = 1 }
            
            if winGame != 0 && game != 0 && numberOfGoals != 0 {
                // Победы. Находим процент побед от общего количества игр (до 70)
                switch Int(Double(winGame) / Double(game) *  100) {
                case 0...50:
//                    print("Райтинг: 61")
                    totalRating = 61
                case 51...67:
//                    print("Райтинг: 65")
                    totalRating = 65
                case 68...100:
//                    print("Райтинг: 70")
                    totalRating = 70
                default:
                    print("Превышение лимита")
                }
                
                // Забитые голы. Находим процент от количества игр и забитых мячей (до 29)
                switch Int(Double(numberOfGoals) / Double(game) *  100) {
                case 0...25:
//                    print("Райтинг: 9")
                    totalRating += 11
                case 26...50:
//                    print("Райтинг: 11")
                    totalRating += 17
                case 51...75:
//                    print("Райтинг: 15")
                    totalRating += 21
                case 76...100:
//                    print("Райтинг: 29")
                    totalRating += 29
                default:
//                    print("Райтинг: 29")
                    totalRating += 29
                }
            }
            return totalRating
        }
        
        if position == "1" {
            var winGame = winGame
            let game = winGame + losGame
            var totalRating = 50
            var numberOfGoals = numberOfGoals
            if numberOfGoals == 0 { numberOfGoals = 1 }
            if winGame == 0 { winGame = 1 }
            
            if winGame != 0 && game != 0 && numberOfGoals != 0 {
                // Победы. Находим процент побед от общего количества игр (до 90)
                switch Int(Double(winGame) / Double(game) *  100) {
                case 0...15:
//                    print("Райтинг: 69")
                    totalRating = 69
                case 16...25:
//                    print("Райтинг: 72")
                    totalRating = 72
                case 26...41:
//                    print("Райтинг: 76")
                    totalRating = 76
                case 42...50:
//                    print("Райтинг: 78")
                    totalRating = 78
                case 51...67:
//                    print("Райтинг: 80")
                    totalRating = 88
                case 68...75:
//                    print("Райтинг: 85")
                    totalRating = 89
                case 76...89:
//                    print("Райтинг: 87")
                    totalRating = 90
                case 90...100:
//                    print("Райтинг: 91")
                    totalRating = 91
                default:
                    print("Превышение лимита")
                }
                
                // Забитые голы. Находим процент от количества игр и забитых мячей (до 19)
                switch Int(Double(numberOfGoals) / Double(game) *  100) {
                case 0...50:
//                    print("Райтинг: 4")
                    totalRating += 4
                case 51...100:
//                    print("Райтинг: 8")
                    totalRating += 8
                default:
//                    print("Райтинг: 19")
                    totalRating += 9
                }
            }
            return totalRating
        }
        
        if position == "2" {
            let game = winGame + losGame
            var totalRating = 50
            var numberOfGoals = numberOfGoals
            if numberOfGoals == 0 { numberOfGoals = 1 }
            if winGame == 0 { totalRating = 78 }
            
            if winGame != 0 && game != 0 && numberOfGoals != 0 {
                // Победы. Находим процент побед от общего количества игр (до 90)
                switch Int(Double(winGame) / Double(game) *  100) {
                case 0...41:
//                    print("Райтинг: 78")
                    totalRating = 78
                case 42...50:
//                    print("Райтинг: 89")
                    totalRating = 89
                case 51...75:
//                    print("Райтинг: 93")
                    totalRating = 93
                case 76...100:
//                    print("Райтинг: 99")
                    totalRating = 99
                default:
                    print("Превышение лимита")
                }
            }
            return totalRating
        }
        
        if position == "3" {
            
            var winGame = winGame
            let game = winGame + losGame
            var totalRating = 50
            if winGame == 0 { winGame = 1 }
            
            if winGame != 0 && game != 0 {
                // Рейтинг у вратаря. Находим процент от выйгранных игр. (до 99)
                switch Int(Double(winGame) / Double(game) *  100) {
                case 0...25:
//                    print("Вратарский райтинг: 78")
                    totalRating = 78
                case 26...50:
//                    print("Вратарский райтинг: 89")
                    totalRating = 89
                case 51...75:
//                    print("Вратарский райтинг: 95")
                    totalRating = 95
                case 76...100:
//                    print("Вратарский райтинг: 99")
                    totalRating = 99
                default:
                    print("Превышение лимита")
                }
            }
            return totalRating
        }
        return 0
    }
}
