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
        
        if position != "ВРТ" {

            let game = winGame + losGame
            var totalRating = 50
            
            if winGame != 0 && game != 0 && numberOfGoals != 0 {
                // Победы. Находим процент побед от общего количества игр (до 80)
                switch Int(Double(winGame) / Double(game) *  100) {
                case 0...15:
//                    print("Райтинг: 61")
                    totalRating = 61
                case 16...25:
//                    print("Райтинг: 65")
                    totalRating = 65
                case 26...41:
//                    print("Райтинг: 68")
                    totalRating = 68
                case 42...50:
//                    print("Райтинг: 70")
                    totalRating = 70
                case 51...67:
//                    print("Райтинг: 73")
                    totalRating = 73
                case 68...75:
//                    print("Райтинг: 75")
                    totalRating = 75
                case 76...89:
//                    print("Райтинг: 78")
                    totalRating = 78
                case 90...100:
//                    print("Райтинг: 80")
                    totalRating = 80
                default:
                    print("Превышение лимита")
                }
                
                // Забитые голы. Находим процент от количества игр и забитых мячей (до 19)
                switch Int(Double(numberOfGoals) / Double(game) *  100) {
                case 0...15:
//                    print("Райтинг: 4")
                    totalRating += 4
                case 16...25:
//                    print("Райтинг: 9")
                    totalRating += 9
                case 26...31:
//                    print("Райтинг: 11")
                    totalRating += 11
                case 32...50:
//                    print("Райтинг: 13")
                    totalRating += 13
                case 51...63:
//                    print("Райтинг: 14")
                    totalRating += 14
                case 64...75:
//                    print("Райтинг: 15")
                    totalRating += 15
                case 76...89:
//                    print("Райтинг: 16")
                    totalRating += 16
                case 90...100:
//                    print("Райтинг: 17")
                    totalRating += 17
                default:
//                    print("Райтинг: 19")
                    totalRating += 19
                }
            }
            return totalRating
        }
        
        if position == "ВРТ" {

            let game = winGame + losGame
            
            var totalRating = 50
            
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
