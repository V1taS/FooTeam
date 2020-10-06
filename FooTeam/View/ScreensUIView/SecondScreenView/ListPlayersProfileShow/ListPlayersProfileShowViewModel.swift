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
    var currentTeam: CurrentTeam { get }
    var cancellables: Set<AnyCancellable> { get }
    
    var team: Team { get }
    var isPresentedShowModal: Bool { get }
    init()
}

class ListPlayersProfileShowViewModel: ListPlayersProfileShowViewModelProtocol, ObservableObject {
    @Published var currentTeam = CurrentTeam()
    internal var cancellables = Set<AnyCancellable>()
    
    @Published var team: Team = Team(
        avatarStringURL: "",
        teamName: "",
        location: "",
        teamType: "",
        rating: 0
    )
    @Published var isPresentedShowModal = false
    
    required init() {
        self.currentTeam.$team.sink { team in
            self.team = team
        } .store(in: &cancellables)
    }
}
