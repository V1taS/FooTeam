//
//  ListPlayersSecondScreenViewModel.swift
//  FooTeam
//
//  Created by Виталий Сосин on 16.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import Foundation

protocol ListPlayersSecondScreenViewModelProtocol {
    var name: String { get }
    var captain: Bool { get }
    
    var playersiGo: [Player] { get }
    var playersReserv: [Player] { get }
    
    init(player: CurrentUser)
    init(listenerPlayers: PlayersListener)
    init(actionsPlayers: ActionsPlayers)
}

class ListPlayersSecondScreenViewModel: ListPlayersSecondScreenViewModelProtocol, ObservableObject {
    
    @Published var name: String = ""
    
    @Published var captain: Bool = false
    
    @Published var playersiGo: [Player] = []
    
    @Published var playersReserv: [Player] = []
    
    var player: Player?
    var listenerPlayers: [Player]?
    var actionsPlayers: [Player]?
    
    required init(player: CurrentUser) {
        player.downloadPlayers()
        
        self.player = player.player
        self.name = player.player.name ?? ""
        self.captain = player.player.captain ?? false
    }
    
    required init(listenerPlayers: PlayersListener) {
        listenerPlayers.downloadPlayers()
        
        self.listenerPlayers = listenerPlayers.players
    }
    
    required init(actionsPlayers: ActionsPlayers) {
        actionsPlayers.downloadPlayers()
        let playersiGo = actionsPlayers.players.filter { $0.iGo }
        let playersReserv = actionsPlayers.players.filter { $0.subscription == false }
        
        self.actionsPlayers = actionsPlayers.players
        self.playersiGo = playersiGo
        self.playersReserv = playersReserv
    }
    
    
}
