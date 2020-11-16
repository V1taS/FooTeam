//
//  DefaultPlayer.swift
//  FooTeam
//
//  Created by Виталий Сосин on 16.11.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import Foundation

class DefaultPlayer {
    static let shared = DefaultPlayer()
    
    let player = Player(
        name: "",
        email: "",
        avatarStringURL: "",
        whoAreYou: "",
        id: "",
        idTeam: "",
        teamNumber: 0,
        payment: "",
        iGo: false,
        subscription: false,
        rating: 0,
        position: "",
        numberOfGoals: 0,
        winGame: 0,
        losGame: 0,
        captain: false
    )

}
