//
//  JoinToTeamViewModel.swift
//  FooTeam
//
//  Created by Виталий Сосин on 21.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import Foundation
import Combine

protocol JoinToTeamViewModelProtocol {
    var teamsListener: TeamsListener { get }
    var cancellables: Set<AnyCancellable> { get }
    
    var teams: [Team] { get }
    var isPresentedAlertSignOut: Bool { get }
    var isPresentedCreateTeam: Bool { get }
    init()
}

class JoinToTeamViewModel: JoinToTeamViewModelProtocol, ObservableObject {
    @Published var teamsListener = TeamsListener()
    internal var cancellables = Set<AnyCancellable>()
    
    @Published var teams: [Team] = []
    @Published var isPresentedAlertSignOut = false
    @Published var isPresentedCreateTeam = false
    
    required init() {
        self.teamsListener.$teams.sink { team in
            self.teams = team
        }
        .store(in: &cancellables)
    }
}
