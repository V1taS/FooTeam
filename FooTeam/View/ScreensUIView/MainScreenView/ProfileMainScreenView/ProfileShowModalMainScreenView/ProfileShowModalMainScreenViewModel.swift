//
//  ProfileShowModalMainScreenViewModel.swift
//  FooTeam
//
//  Created by Виталий Сосин on 16.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import Foundation

protocol ProfileShowModalMainScreenViewModelProtocol {
    var name: String { get }
    var avatarStringURL: String { get }
    var rating: Int { get }
    var position: String { get }
    var numberOfGames: Int { get }
    var numberOfGoals: Int { get }
    var winGame: Int { get }
    var losGame: Int { get }
    var nameTeam: String { get }
    var payment: String { get }
    var subscription: Bool { get }
    var iGo: Bool { get }
    var captain: Bool { get }
    
    var closeShowModal: Bool { get }
    var isPresentedEditorProfile: Bool { get }
    
    init(player: CurrentUser)
    init(players: PlayersListener)
}

class ProfileShowModalMainScreenViewModel: ProfileShowModalMainScreenViewModelProtocol, ObservableObject {
    
    @Published var name: String = ""
    
    @Published var avatarStringURL: String = ""
    
    @Published var rating: Int = 0
    
    @Published var position: String = ""
    
    @Published var numberOfGames: Int = 0
    
    @Published var numberOfGoals: Int = 0
    
    @Published var winGame: Int = 0
    
    @Published var losGame: Int = 0
    
    @Published var nameTeam: String = ""
    
    @Published var payment: String = ""
    
    @Published var subscription: Bool = false
    
    @Published var iGo: Bool = false
    
    @Published var captain: Bool = false
    
    @Published var closeShowModal: Bool = false // Настроить логику
    
    @Published var isPresentedEditorProfile: Bool = false // Настроить логику
    
    var currentPlayer: Players?
    var listenerPlayers: [Players]?
    
    required init(player: CurrentUser) {
        player.downloadPlayers()
        self.currentPlayer = player.player ?? Players(name: "", nameTeam: "", email: "", avatarStringURL: "", whoAreYou: "", id: "", idTeam: "", teamNumber: 0, payment: "", iGo: false, subscription: false, rating: 0, position: "", numberOfGames: 0, numberOfGoals: 0, winGame: 0, losGame: 0, captain: false)
        
        self.name = player.player?.name ?? ""
        self.avatarStringURL = player.player?.avatarStringURL ?? ""
        self.rating = player.player?.rating ?? 0
        self.position = player.player?.position ?? ""
        self.numberOfGames = player.player?.numberOfGames ?? 0
        self.numberOfGoals = player.player?.numberOfGoals ?? 0
        self.winGame = player.player?.winGame ?? 0
        self.losGame = player.player?.losGame ?? 0
        self.nameTeam = player.player?.nameTeam ?? ""
        self.payment = player.player?.payment ?? ""
        self.subscription = player.player?.subscription ?? false
        self.iGo = player.player?.iGo ?? false
        self.captain = player.player?.captain ?? false
    }
    
    required init(players: PlayersListener) {
        players.downloadPlayers()
        self.listenerPlayers = players.players
    }
}
