//
//  GetDateStringFromDate.swift
//  FooTeam
//
//  Created by Виталий Сосин on 30.10.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import Foundation

class GetDateStringFromDate {
    static let shared = GetDateStringFromDate()
    
    func GetDateString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let time = dateFormatter.string(from: date)
        return time
    }
}
