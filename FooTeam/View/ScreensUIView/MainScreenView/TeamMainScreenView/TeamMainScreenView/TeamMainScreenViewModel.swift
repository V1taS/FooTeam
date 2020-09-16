//
//  TeamMainScreenViewModel.swift
//  FooTeam
//
//  Created by Виталий Сосин on 16.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import Foundation

protocol TeamMainScreenViewModelProtocol {
    var iGoCount: Int { get }
    var playersCount: Int { get }
    var isPresentedListTeams: Bool { get }
    
    init(players: ActionsPlayers)
}

class TeamMainScreenViewModel: TeamMainScreenViewModelProtocol, ObservableObject {
    
    @Published var iGoCount: Int = 0
    
    @Published var  playersCount: Int = 0
    
    @Published var  isPresentedListTeams: Bool = false // Настроить логику
    
    required init(players: ActionsPlayers) {
        players.downloadPlayers()
        let playersIgo = players.players.filter { $0.iGo }
        
        self.iGoCount = playersIgo.count
        self.playersCount = players.players.count
    }
    
    
}
