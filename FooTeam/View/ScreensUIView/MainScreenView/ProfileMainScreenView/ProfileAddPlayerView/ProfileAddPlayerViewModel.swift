//
//  ProfileAddPlayerViewModel.swift
//  FooTeam
//
//  Created by Виталий Сосин on 16.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import Foundation

protocol ProfileAddPlayerViewModelProtocol {
    var name: String { get }
    var avatarStringURL: String { get }
    var position: String { get }
    var nameTeam: String { get }
    var payment: String { get }
    var subscription: Bool { get }
    var iGo: Bool { get }
    
    var whoAreYou: [String] { get }
    var selectionWhoAreYou: Int { get }
    
    var positions: [String] { get }
    var selectionPositions: Int { get }
    
    var closeShowModal: Bool { get }
    
    init(player: CurrentUser)
}


class ProfileAddPlayerViewModel: ProfileAddPlayerViewModelProtocol, ObservableObject {
    
    @Published var name: String = ""
    
    @Published var avatarStringURL: String = ""
    
    @Published var position: String = ""
    
    @Published var nameTeam: String = ""
    
    @Published var payment: String = ""
    
    @Published var subscription: Bool = false
    
    @Published var iGo: Bool = false
    
    var whoAreYou: [String] = ["Игрок", "Зритель"] // Настроить логику
    
    @Published var selectionWhoAreYou: Int = 0 // Настроить логику
    
    var positions: [String] = ["ФРВ", "ЦП", "ЦЗ", "ВРТ"] // Настроить логику
    
    @Published var selectionPositions: Int = 0 // Настроить логику
    
    @Published var closeShowModal: Bool = false // Настроить логику
    
    var currentPlayer: Players?
    
    required init(player: CurrentUser) {
        player.downloadPlayers()
        self.currentPlayer = player.player ?? Players(name: "", nameTeam: "", email: "", avatarStringURL: "", whoAreYou: "", id: "", idTeam: "", teamNumber: 0, payment: "", iGo: false, subscription: false, rating: 0, position: "", numberOfGames: 0, numberOfGoals: 0, winGame: 0, losGame: 0, captain: false)
        
        self.name = player.player?.name ?? ""
        self.avatarStringURL = player.player?.avatarStringURL ?? ""
        self.position = player.player?.position ?? ""
        self.nameTeam = player.player?.nameTeam ?? ""
        self.payment = player.player?.payment ?? ""
        self.subscription = player.player?.subscription ?? false
        self.iGo = player.player?.iGo ?? false
    }
}
