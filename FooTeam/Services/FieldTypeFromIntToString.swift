//
//  FieldTypeFromIntToString.swift
//  FooTeam
//
//  Created by Виталий Сосин on 08.11.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import Foundation

import Foundation

class FieldTypeFromIntToString {
    
    static let shared = FieldTypeFromIntToString()
    
    func setFieldType(from data: String) -> String {
        switch data {
        case "0":
            return "Мини"
        case "1":
            return "Большое"
        default:
            print("")
        }
        return ""
    }
}
