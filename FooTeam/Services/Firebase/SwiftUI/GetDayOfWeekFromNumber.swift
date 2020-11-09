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
            return NSLocalizedString("GetDayOfWeekFromNumberWeekdayMonday", comment: "Monday")
        case "1":
            return NSLocalizedString("GetDayOfWeekFromNumberWeekdayTuesday", comment: "Tuesday")
        case "2":
            return NSLocalizedString("GetDayOfWeekFromNumberWeekdayWednesday", comment: "Wednesday")
        case "3":
            return NSLocalizedString("GetDayOfWeekFromNumberWeekdayThursday", comment: "Thursday")
        case "4":
            return NSLocalizedString("GetDayOfWeekFromNumberWeekdayFriday", comment: "Friday")
        case "5":
            return NSLocalizedString("GetDayOfWeekFromNumberWeekdaySaturday", comment: "Saturday")
        case "6":
            return NSLocalizedString("GetDayOfWeekFromNumberWeekdaySunday", comment: "Sunday")
        default:
            return ""
        }
    }
}
