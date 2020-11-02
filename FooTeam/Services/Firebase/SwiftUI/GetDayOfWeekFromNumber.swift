//
//  GetDayOfWeekFromNumber.swift
//  FooTeam
//
//  Created by Виталий Сосин on 30.10.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import Foundation

class GetDayOfWeekFromNumber {
    static let shared = GetDayOfWeekFromNumber()
    
    func GetDayOfWeek(numberString: String) -> String {
        switch numberString {
        case "0":
            return "Понедельник"
        case "1":
            return "Вторник"
        case "2":
            return "Среда"
        case "3":
            return "Четверг"
        case "4":
            return "Пятница"
        case "5":
            return "Суббота"
        case "6":
            return "Воскресенье"
        default:
            return ""
        }
    }
}
