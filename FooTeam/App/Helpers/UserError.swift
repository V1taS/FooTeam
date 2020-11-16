//
//  UserError.swift
//  FooTeam
//
//  Created by Виталий Сосин on 17.07.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import Foundation

enum UserError {
    case notFilled
    case photoNotExist
    case cannotUnwrapToMUser
    case cannotGetUserInfo
}

extension UserError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .notFilled:
            return NSLocalizedString("UserErrorFillAllFields",
                                     comment: "Fill in all the fields")
        case .photoNotExist:
            return NSLocalizedString("UserErrorDidntChoosePhoto",
                                     comment: "User has not selected a photo")
        case .cannotGetUserInfo:
            return NSLocalizedString("UserErrorUnableLoadInformation",
                                     comment: "Unable to load User information from Firebase")
        case .cannotUnwrapToMUser:
            return NSLocalizedString("UserErrorUnableConvert",
                                     comment: "Unable to convert MUser from User")
        }
    }
}
