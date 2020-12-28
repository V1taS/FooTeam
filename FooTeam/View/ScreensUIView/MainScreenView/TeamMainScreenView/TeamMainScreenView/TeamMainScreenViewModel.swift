//
//  TeamMainScreenViewModel.swift
//  FooTeam
//
//  Created by Виталий Сосин on 16.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import Foundation
import Combine

protocol TeamMainScreenViewModelProtocol {
    var actionsPlayers: ActionsPlayers { get }
    var cancellables: Set<AnyCancellable> { get }
    
    var iGoCount: Int { get }
    var playersCount: Int { get }
    var isPresentedShowModal: Bool { get }
    init()
}

class TeamMainScreenViewModel: TeamMainScreenViewModelProtocol, ObservableObject {
    @Published var actionsPlayers = ActionsPlayers()
    internal var cancellables = Set<AnyCancellable>()
    
    @Published var iGoCount: Int = 0
    @Published var  playersCount: Int = 0
    @Published var isPresentedShowModal: Bool = false
    
    required init() {
        self.actionsPlayers.$players.sink { players in
            let iGoCount = players.filter { $0.iGo }
            self.iGoCount = iGoCount.count
            self.playersCount = players.count
        } .store(in: &cancellables)
    }
}
