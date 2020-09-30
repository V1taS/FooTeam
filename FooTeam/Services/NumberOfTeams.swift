//
//  NumberOfTeams.swift
//  FooTeam
//
//  Created by Виталий Сосин on 25.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import Foundation

class NumberOfTeams: ObservableObject {
    
    static let shared = NumberOfTeams()
    
    func numberOfTeams(countPlauers: Int) -> Int {
        
        if countPlauers < 10 {
//            print("Количество игроков: \(countPlauers)")
//            print("Мало игроков")
            return 0
            
        }
        
        if countPlauers >= 10 && countPlauers <= 11 {
            if countPlauers % 2 == 0 {
//                print("Количество игроков: \(countPlauers)")
//                print("Две команды по 5 игроков")
                return 2
            } else {
//                print("Количество игроков: \(countPlauers)")
//                print("Две команды по 5 игроков, в одной из команд +1 игрок")
                return 2
            }
        }
        
        if countPlauers >= 12 && countPlauers <= 13 {
            if countPlauers % 2 == 0 {
//                print("Количество игроков: \(countPlauers)")
//                print("Две команды по 6 игроков")
                return 2
            } else {
//                print("Количество игроков: \(countPlauers)")
//                print("Две команды по 6 игроков, в одной из команд +1 игрок")
                return 2
            }
        }
        
        if countPlauers >= 14 && countPlauers <= 15 {
            if countPlauers % 3 == 0 {
//                print("Количество игроков: \(countPlauers)")
//                print("Три команды по 5 игроков")
                return 3
            } else {
//                print("Количество игроков: \(countPlauers)")
//                print("Три команды по 5 игроков, в одной из команд -1 игрок")
                return 3
            }
        }
        
        if countPlauers == 16 {
//            print("Количество игроков: \(countPlauers)")
//            print("Три команды по 5 игроков, в одной из команд +1 игрок")
            return 3
        }
        
        if countPlauers == 17 {
//            print("Количество игроков: \(countPlauers)")
//            print("Три команды по 6 игроков, в одной из команд -1 игрок")
            return 3
        }
        
        if countPlauers == 18 {
//            print("Количество игроков: \(countPlauers)")
//            print("Три команды по 6 игроков")
            return 3
        }
        
        if countPlauers == 19 {
//            print("Количество игроков: \(countPlauers)")
//            print("Четыре команды по 5 игроков, в одной из команд -1 игрок")
            return 4
        }
        
        if countPlauers == 20 {
//            print("Количество игроков: \(countPlauers)")
//            print("Четыре команды по 5 игроков")
//            print("*** или ***")
//            print("Две команды по 10 человек")
            return 4
        }
        
        
        
        if countPlauers == 21 {
//            print("Количество игроков: \(countPlauers)")
//            print("Четыре команды по 5 игроков, в одной из команд +1 игрок")
//            print("*** или ***")
//            print("Две команды по 10 человек, в одной из команд +1 игрок")
            return 4
        }
        
        
        
        if countPlauers == 22 {
//            print("Количество игроков: \(countPlauers)")
//            print("Четыре команды по 5 игроков, в одной из команд +2 игрока")
//            print("*** или ***")
//            print("Две команды по 11 человек")
            return 4
        }
        
        
        
        if countPlauers >= 23 {
//            print("Количество игроков: \(countPlauers)")
//            print("Много игроков")
            return 0
            
        }
        return 0
    }
}
