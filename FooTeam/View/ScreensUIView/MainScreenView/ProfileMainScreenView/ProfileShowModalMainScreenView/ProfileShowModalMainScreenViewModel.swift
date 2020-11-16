//
//  ProfileShowModalMainScreenViewModel.swift
//  FooTeam
//
//  Created by Виталий Сосин on 16.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import Foundation
import Combine

protocol ProfileShowModalMainScreenViewModelProtocol {
    var currentUser: CurrentUser { get }
    var currentTeam: CurrentTeam { get }
    var actionsPlayers: ActionsPlayers { get }
    var cancellables: Set<AnyCancellable> { get }
    
    var player: Player { get }
    var players: [Player] { get }
    var team: Team { get }
    
    var isPresentedProfileEditor: Bool { get }
    var isPresentedAlert: Bool { get }
    var outFromTeam: Bool { get }
    
    init()
}

class ProfileShowModalMainScreenViewModel: ProfileShowModalMainScreenViewModelProtocol, ObservableObject {
    @Published var currentUser = CurrentUser()
    @Published var currentTeam = CurrentTeam()
    @Published var actionsPlayers = ActionsPlayers()
    internal var cancellables = Set<AnyCancellable>()
    
    @Published var player: Player = DefaultPlayer.shared.player
    @Published var players: [Player] = []
    @Published var team: Team = DefaultTeam.shared.team
    
    @Published var isPresentedProfileEditor: Bool = false
    @Published var isPresentedAlert: Bool = false
    @Published var outFromTeam: Bool = false
    
    required init() {
        self.actionsPlayers.$players.sink { players in
            self.players = players
        } .store(in: &cancellables)
        
        self.currentUser.$player
            .assign(to: \.player, on: self)
            .store(in: &self.cancellables)
        
        self.currentTeam.$team.sink { team in
            self.team = team
        } .store(in: &cancellables)
    }
}
