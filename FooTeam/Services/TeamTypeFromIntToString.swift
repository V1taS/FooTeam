//
//  TeamTypeFromIntToString.swift
//  FooTeam
//
//  Created by Виталий Сосин on 08.11.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import Foundation

class TeamTypeFromIntToString {
    
    static let shared = TeamTypeFromIntToString()
    
    func setTeamType(from data: String) -> String {
        switch data {
        case "0":
            return "Открытая"
        case "1":
            return "Закрытая"
        default:
            print("")
        }
        return ""
    }
}
