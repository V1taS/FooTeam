//
//  AuthError.swift
//  iChat
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
            return NSLocalizedString("Заполните все поля", comment: "")
        case .invalidEmail:
            return NSLocalizedString("Формат почты не является допустимым", comment: "")
        case .passwordsNotMatched:
            return NSLocalizedString("Пароли не совпадают", comment: "")
        case .unknownError:
            return NSLocalizedString("Неизвестная ошибка", comment: "")
        case .serverError:
            return NSLocalizedString("Ошибка сервера", comment: "")
        }
    }
}

