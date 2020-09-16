//
//  TabViewFooTeamModel.swift
//  FooTeam
//
//  Created by Виталий Сосин on 16.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI

protocol TabViewFooTeamModelProtocol {
    var waitingPlayersCount: Int { get }
    var viewState: CGSize { get }
    var showWaitingPlayer: Int { get }
    
    init(waitingPlayers: WaitingPlayers)
}

class TabViewFooTeamModel: TabViewFooTeamModelProtocol, ObservableObject {
    
    @Published var waitingPlayersCount: Int = 0
    
    @Published var viewState: CGSize = .zero // Настроить логику
    
    @Published var showWaitingPlayer: Int = 0 // Настроить логику
    
    required init(waitingPlayers: WaitingPlayers) {
        waitingPlayers.downloadPlayers()
        
        self.waitingPlayersCount = waitingPlayers.players.count
    }
    
    
}
