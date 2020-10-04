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
    var playerListener: Player { get }
}

class ListPlayersProfileShowViewModel: ListPlayersProfileShowViewModelProtocol, ObservableObject {

    @Published var currentTeam = CurrentTeam()
    private var cancellables = Set<AnyCancellable>()
    
    @Published var playerListener: Player = Player(name: "Default player", email: "", avatarStringURL: "", whoAreYou: "", id: "", idTeam: "", teamNumber: 0, payment: "", iGo: false, subscription: false, rating: 0, position: "", numberOfGoals: 0, winGame: 0, losGame: 9, captain: false)
    @Published var nameTeam: String = ""
    
    init() {
        self.currentTeam.$team.sink { team in
            self.nameTeam = team.teamName ?? ""
            } .store(in: &cancellables)
    }
}
