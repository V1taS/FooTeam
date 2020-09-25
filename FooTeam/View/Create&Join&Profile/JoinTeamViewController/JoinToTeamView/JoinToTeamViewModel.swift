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
    var teams: [Team] { get }
}

class JoinToTeamViewModel: JoinToTeamViewModelProtocol, ObservableObject {

    @Published var teamsListener = TeamsListener()
    private var cancellables = Set<AnyCancellable>()
    
    @Published var teams: [Team] = []
    
    init() {
        self.teamsListener.$teams.sink { team in
            self.teams = team
        }
        .store(in: &cancellables)
    }
}
