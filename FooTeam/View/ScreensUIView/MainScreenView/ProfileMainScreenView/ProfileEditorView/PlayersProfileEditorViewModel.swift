//
//  ListPlayersProfileEditorViewModel.swift
//  FooTeam
//
//  Created by Виталий Сосин on 21.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import Foundation
import Combine

protocol ListPlayersProfileEditorViewModelProtocol {
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
    var email: String { get }
    
    var whoAreYou: [String] { get }
    var selectionWhoAreYou: Int { get }
    
    var positions: [String] { get }
    var selectionPositions: Int { get }
}

class PlayersProfileEditorViewModel: ListPlayersProfileEditorViewModelProtocol, ObservableObject {

    @Published var playersListener = ActionsPlayers()
    @Published var currentPlayer = Player(name: "Default player", nameTeam: "", email: "", avatarStringURL: "", whoAreYou: "", id: "", idTeam: "", teamNumber: 0, payment: "", iGo: false, subscription: false, rating: 0, position: "", numberOfGames: 0, numberOfGoals: 0, winGame: 0, losGame: 9, captain: false)
    @Published var currentPlayers: [Player] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published var bufferID: String = ""
    
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
    @Published var email: String = ""
    
    var whoAreYou: [String] = ["Игрок", "Зритель"] // Настроить логику
    @Published var selectionWhoAreYou: Int = 0 // Настроить логику
    
    var positions: [String] = ["ФРВ", "ЦП", "ЦЗ", "ВРТ"] // Настроить логику
    @Published var selectionPositions: Int = 0 // Настроить логику
    
    init() {
        
        self.playersListener.$players.sink { [self] player in
            let currentPL = player.filter { $0.id == BufferIDplayer.shared.playerID }
            let currentNewPL = currentPL.first ?? Player(name: "Default player", nameTeam: "", email: "", avatarStringURL: "", whoAreYou: "", id: "", idTeam: "", teamNumber: 0, payment: "", iGo: false, subscription: false, rating: 0, position: "", numberOfGames: 0, numberOfGoals: 0, winGame: 0, losGame: 9, captain: false)
            
            self.name = currentNewPL.name
            self.avatarStringURL = currentNewPL.avatarStringURL
            self.rating = currentNewPL.rating
            self.position = currentNewPL.position
            self.numberOfGames = currentNewPL.numberOfGames
            self.numberOfGoals = currentNewPL.numberOfGoals
            self.winGame = currentNewPL.winGame
            self.losGame = currentNewPL.losGame
            self.nameTeam = currentNewPL.nameTeam
            self.payment = currentNewPL.payment
            self.subscription = currentNewPL.subscription
            self.iGo = currentNewPL.iGo
            self.captain = currentNewPL.captain
            self.email = currentNewPL.email
            self.currentPlayer = currentNewPL
            
            
            self.currentPlayers = player
        }
        .store(in: &cancellables)
    }
    
    
}
