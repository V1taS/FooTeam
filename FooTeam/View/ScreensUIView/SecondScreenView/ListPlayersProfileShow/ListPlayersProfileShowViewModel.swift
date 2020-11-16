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
    var actionsPlayers: ActionsPlayers { get }
    var currentTeam: CurrentTeam { get }
    var cancellables: Set<AnyCancellable> { get }
    
    var player: Player { get }
    var team: Team { get }
    var isPresentedShowModal: Bool { get }
    var playerID: String { get }
    init()
}

class ListPlayersProfileShowViewModel: ListPlayersProfileShowViewModelProtocol, ObservableObject {
    @Published var actionsPlayers = ActionsPlayers()
    @Published var currentTeam = CurrentTeam()
    internal var cancellables = Set<AnyCancellable>()
    
    @Published var player: Player = DefaultPlayer.shared.player
    @Published var team: Team = DefaultTeam.shared.team
    @Published var isPresentedShowModal = false
    @Published var playerID = ""
    
    required init() {
        self.actionsPlayers.$players.sink { players in
            let bufferIDplayer = players.filter { $0.id == self.playerID }
            let bufferIDplayerCheck = bufferIDplayer.first ?? DefaultPlayer.shared.player
            self.player = bufferIDplayerCheck
            BufferIDplayer.shared.saveUserID(id: bufferIDplayerCheck.id)
        } .store(in: &cancellables)
        
        self.currentTeam.$team.sink { team in
            self.team = team
        } .store(in: &cancellables)
    }
}
