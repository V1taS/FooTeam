//
//  ListPlayersProfileEditorViewModel.swift
//  FooTeam
//
//  Created by Виталий Сосин on 21.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI
import Combine

protocol ListPlayersProfileEditorViewModelProtocol {
    var actionsPlayers: ActionsPlayers { get }
    var currentTeam: CurrentTeam { get }
    var cancellables: Set<AnyCancellable> { get }
    
    var bufferID: String { get }
    var deletPlayer: Bool { get }
    var isPresentedChangeAvatar: Bool { get }
    var passwordPlayer: String { get }
    
    var players: [Player] { get }
    var player: Player { get }
    var team: Team { get }
    
    var whoAreYou: [String] { get }
    var selectionWhoAreYou: Int { get }
    
    var positions: [String] { get }
    var selectionPositions: Int { get }
    var image: UIImage { get }
    init()
}

class PlayersProfileEditorViewModel: ListPlayersProfileEditorViewModelProtocol, ObservableObject {
    @Published var actionsPlayers = ActionsPlayers()
    @Published var currentTeam = CurrentTeam()
    internal var cancellables = Set<AnyCancellable>()

    @Published var bufferID: String = ""
    @Published var deletPlayer = false
    @Published var isPresentedChangeAvatar: Bool = false
    @Published var passwordPlayer = ""
    
    @Published var players: [Player] = []
    @Published var player: Player = DefaultPlayer.shared.player
    @Published var team: Team = DefaultTeam.shared.team
    
    var whoAreYou: [String] = [
        NSLocalizedString("PlayersProfileEditorWhoAreYouPlayer",
                          comment: "Player"),
        NSLocalizedString("PlayersProfileEditorWhoAreYouViewer",
                          comment: "Viewer")
    ]
    @Published var selectionWhoAreYou: Int = 0
    
    var positions: [String] = [NSLocalizedString("PlayersProfileEditorPositionSt",
                                                 comment: "ST"),
                               NSLocalizedString("PlayersProfileEditorPositionMC",
                                                 comment: "MC"),
                               NSLocalizedString("PlayersProfileEditorPositionDC",
                                                 comment: "DC"),
                               NSLocalizedString("PlayersProfileEditorPositionGK",
                                                 comment: "GK")]
    @Published var selectionPositions: Int = 0
    @Published var image = UIImage()
    
    required init() {
        self.actionsPlayers.$players.sink { players in
            let bufferIDplayer = players.filter { $0.id == BufferIDplayer.shared.playerID }
            let bufferIDplayerCheck = bufferIDplayer.first ?? DefaultPlayer.shared.player
            
            switch bufferIDplayerCheck.whoAreYou {
            case "0":
                self.selectionWhoAreYou = 0
            case "1":
                self.selectionWhoAreYou = 1
            default:
                self.selectionWhoAreYou = 0
            }
            
            switch bufferIDplayerCheck.position {
            case "0":
                self.selectionPositions = 0
            case "1":
                self.selectionPositions = 1
            case "2":
                self.selectionPositions = 2
            case "3":
                self.selectionPositions = 3
            default:
                self.selectionPositions = 0
            }
            self.player = bufferIDplayerCheck
            self.players = players
        } .store(in: &cancellables)
        
        self.currentTeam.$team.sink { team in
            self.team = team
        } .store(in: &cancellables)
    }
}
