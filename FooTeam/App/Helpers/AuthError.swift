//
//  AuthError.swift
//  FooTeam
//
//  Created by Виталий Сосин on 16.07.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import Foundation

enum AuthError {
    case notFilled
    case invalidEmail
    case passwordsNotMatched
    case unknownError
    case serverError
}

extension AuthError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .notFilled:
            return NSLocalizedString("AuthErrorFillInAllTheFields",
                                     comment: "Fill in all the fields")
        case .invalidEmail:
            return NSLocalizedString("AuthErrorMailFormatIsNotValid",
                                     comment: "Mail format is not valid")
        case .passwordsNotMatched:
            return NSLocalizedString("AuthErrorPasswordsDoNotMatch",
                                     comment: "Passwords do not match")
        case .unknownError:
            return NSLocalizedString("AuthErrorUnknownError",
                                     comment: "Unknown error")
        case .serverError:
            return NSLocalizedString("AuthErrorServerError",
                                     comment: "Server error")
        }
    }
}

