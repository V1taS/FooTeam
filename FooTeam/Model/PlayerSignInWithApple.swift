//
//  PlayerSignInWithApple.swift
//  FooTeam
//
//  Created by Виталий Сосин on 09.11.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import UIKit
import AuthenticationServices

struct PlayerSignInWithApple: Hashable, Decodable {
    var name: String
    var email: String
    var id: String
    
    init(credentionals: ASAuthorizationAppleIDCredential) {
        self.id = credentionals.user
        self.email = credentionals.email ?? ""
        self.name = "\(credentionals.fullName?.givenName ?? "") \(credentionals.fullName?.familyName ?? "")"
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: PlayerSignInWithApple, rhs: PlayerSignInWithApple) -> Bool {
        return lhs.id == rhs.id
    }
    
    func contains(filter: String?) -> Bool {
        guard let filter = filter else { return true }
        if filter.isEmpty { return true }
        let lowercasedFilter = filter.lowercased()
        return name.lowercased().contains(lowercasedFilter)
    }
}

