//
//  FieldTypeFromIntToString.swift
//  FooTeam
//
//  Created by Виталий Сосин on 08.11.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import Foundation

class FieldTypeFromIntToString {
    
    static let shared = FieldTypeFromIntToString()
    
    func setFieldType(from data: String) -> String {
        switch data {
        case "0":
            return NSLocalizedString("FieldTypeFromIntToStringFieldTypeMini",
                                     comment: "Mini")
        case "1":
            return NSLocalizedString("FieldTypeFromIntToStringFieldTypeFull",
                                     comment: "Big")
        default: return ""
        }
    }
}
