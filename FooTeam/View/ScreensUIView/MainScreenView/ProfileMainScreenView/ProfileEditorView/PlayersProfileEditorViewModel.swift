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
    var actionsPlayers: ActionsPlayers { get }
    var currentTeam: CurrentTeam { get }
    var cancellables: Set<AnyCancellable> { get }
    
    var bufferID: String { get }
    var deletPlayer: Bool { get }
    var isPresentedChangeAvatar: Bool { get }
    
    var players: [Player] { get }
    var player: Player { get }
    var team: Team { get }
    
    var whoAreYou: [String] { get }
    var selectionWhoAreYou: Int { get }
    
    var positions: [String] { get }
    var selectionPositions: Int { get }
    init()
}

class PlayersProfileEditorViewModel: ListPlayersProfileEditorViewModelProtocol, ObservableObject {
    @Published var actionsPlayers = ActionsPlayers()
    @Published var currentTeam = CurrentTeam()
    internal var cancellables = Set<AnyCancellable>()
    
    @Published var bufferID: String = ""
    @Published var deletPlayer = false
    @Published var isPresentedChangeAvatar: Bool = false
    
    @Published var players: [Player] = []
    @Published var player: Player = Player(
        name: "Имя",
        email: "почта@mail.ru",
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
        losGame: 9,
        captain: false
    )
    @Published var team: Team = Team(
        avatarStringURL: "",
        teamName: "",
        location: "",
        teamType: "",
        rating: 0
    )
    
    var whoAreYou: [String] = ["Игрок", "Зритель"] // Настроить логику
    @Published var selectionWhoAreYou: Int = 0 // Настроить логику
    
    var positions: [String] = ["ФРВ", "ЦП", "ЦЗ", "ВРТ"] // Настроить логику
    @Published var selectionPositions: Int = 0 // Настроить логику
    
    required init() {
        self.actionsPlayers.$players.sink { players in
            let bufferIDplayer = players.filter { $0.id == BufferIDplayer.shared.playerID }
            let bufferIDplayerCheck = bufferIDplayer.first ?? Player(name: "Default player", email: "", avatarStringURL: "", whoAreYou: "", id: "", idTeam: "", teamNumber: 0, payment: "", iGo: false, subscription: false, rating: 0, position: "", numberOfGoals: 0, winGame: 0, losGame: 9, captain: false)
            
            self.player = bufferIDplayerCheck
            self.players = players
        } .store(in: &cancellables)
        
        self.currentTeam.$team.sink { team in
            self.team = team
        } .store(in: &cancellables)
    }
}
