//
//  PositionFromIntToString.swift
//  FooTeam
//
//  Created by Виталий Сосин on 08.11.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import Foundation

class PositionFromIntToString {
    
    static let shared = PositionFromIntToString()
    
    func setPosition(position: String) -> String {
        switch position {
        case "0":
            return "ФРВ"
        case "1":
            return "ЦП"
        case "2":
            return "ЦЗ"
        case "3":
            return "ВРТ"
        default:
            print("")
        }
        return ""
    }
}
