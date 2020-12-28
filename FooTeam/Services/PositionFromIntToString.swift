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
            return NSLocalizedString("PositionFromIntToStringPositionSt",
                                     comment: "ST")
        case "1":
            return NSLocalizedString("PositionFromIntToStringPositionMC",
                                     comment: "MC")
        case "2":
            return NSLocalizedString("PositionFromIntToStringPositionDC",
                                     comment: "DC")
        case "3":
            return NSLocalizedString("PositionFromIntToStringPositionGK",
                                     comment: "GK")
        default: return ""
        }
    }
}
