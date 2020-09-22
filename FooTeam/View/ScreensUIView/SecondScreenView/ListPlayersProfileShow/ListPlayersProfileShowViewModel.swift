//
//  ListPlayersProfileShowViewModel.swift
//  FooTeam
//
//  Created by Виталий Сосин on 21.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import Foundation
import Combine

protocol ListPlayersProfileShowViewModelProtocol {
    var playerListener: Player { get }
}

class ListPlayersProfileShowViewModel: ListPlayersProfileShowViewModelProtocol, ObservableObject {
    
    @Published var playerListener: Player = Player(name: "Default player", nameTeam: "", email: "", avatarStringURL: "", whoAreYou: "", id: "", idTeam: "", teamNumber: 0, payment: "", iGo: false, subscription: false, rating: 0, position: "", numberOfGames: 0, numberOfGoals: 0, winGame: 0, losGame: 9, captain: false)
}