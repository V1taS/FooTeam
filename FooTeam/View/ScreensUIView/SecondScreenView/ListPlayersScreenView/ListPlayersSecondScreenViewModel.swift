//
//  ListPlayersSecondScreenViewModel.swift
//  FooTeam
//
//  Created by Виталий Сосин on 16.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import Foundation
import Combine

protocol ListPlayersSecondScreenViewModelProtocol {
    var actionsPlayers: ActionsPlayers { get }
    var cancellables: Set<AnyCancellable> { get }
    
    var captain: Bool { get }
    var isPresentedShowModal: Bool { get }
    
    var playersiGo: [Player] { get }
    var playersReserv: [Player] { get }
    var playersMain: [Player] { get }
    init()
}

class ListPlayersSecondScreenViewModel: ListPlayersSecondScreenViewModelProtocol, ObservableObject {
    @Published var actionsPlayers = ActionsPlayers()
    internal var cancellables = Set<AnyCancellable>()
    
    @Published var captain: Bool = false
    @Published var isPresentedShowModal: Bool = false
    
    @Published var playersiGo: [Player] = []
    @Published var playersMain: [Player] = []
    @Published var playersReserv: [Player] = []
    
    required init() {
        self.actionsPlayers.$players.sink { players in
            let playersiGo = players.filter { $0.iGo }
            let playersMain = players.filter { $0.subscription }
            let playersReserv = players.filter { !$0.subscription }
            
            self.playersiGo = playersiGo
            self.playersMain = playersMain
            self.playersReserv = playersReserv
        } .store(in: &cancellables)
    }
}
