//
//  DefaultTeam.swift
//  FooTeam
//
//  Created by Виталий Сосин on 16.11.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import Foundation

class DefaultTeam {
    static let shared = DefaultTeam()
    
    let team = Team(
        avatarStringURL: "",
        teamName: "",
        location: "",
        teamType: "",
        rating: 0,
        maxCountPlayersInTeam: 0,
        isHidden: false,
        currentCountPlayersInTeam: 0,
        country: "",
        totalMoney: "",
        gameСosts: "",
        fieldType: ""
    )
}
