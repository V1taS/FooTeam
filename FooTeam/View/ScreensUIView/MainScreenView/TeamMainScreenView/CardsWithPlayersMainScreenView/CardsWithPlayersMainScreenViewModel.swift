//
//  CardsWithPlayersMainScreenViewModel.swift
//  FooTeam
//
//  Created by Виталий Сосин on 16.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import Foundation

protocol CardsWithPlayersMainScreenViewModelProtocol {
    var name: String { get }
    var ratingTeam: Int { get }
    
    init(players: ActionsPlayers)
}

class CardsWithPlayersMainScreenViewModel: CardsWithPlayersMainScreenViewModelProtocol, ObservableObject {
    
    @Published var name: String
    
    @Published var ratingTeam: Int
    
    required init(players: ActionsPlayers) {
        players.downloadPlayers()
        
        self.name = players.players.first?.name ?? ""  // Список имен в команде, настроить логику
        self.ratingTeam = players.players.first?.rating ?? 0 // Средний рейтинг команды, настроить логику
    }
    
    
}
