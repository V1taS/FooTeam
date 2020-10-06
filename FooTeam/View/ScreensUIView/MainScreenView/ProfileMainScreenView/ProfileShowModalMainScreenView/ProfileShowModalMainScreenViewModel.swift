//
//  ProfileShowModalMainScreenViewModel.swift
//  FooTeam
//
//  Created by Виталий Сосин on 16.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI
import Combine

protocol ProfileShowModalMainScreenViewModelProtocol {
    var player: Player { get }
    var isPresentedProfileEditor: Bool { get }
    var isPresentedAlert: Bool { get }
    var outFromTeam: Bool { get }
}

class ProfileShowModalMainScreenViewModel: ProfileShowModalMainScreenViewModelProtocol, ObservableObject {
    
    @Published var currentUser = CurrentUser()
    @Published var currentTeam = CurrentTeam()
    private var cancellables = Set<AnyCancellable>()
    
    @Published var player: Player = Player(
        name: "Default player",
        email: "",
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
    
    @Published var isPresentedProfileEditor: Bool = false
    @Published var isPresentedAlert: Bool = false
    @Published var outFromTeam: Bool = false
    
    init() {
        self.currentUser.$player
            .assign(to: \.player, on: self)
            .store(in: &self.cancellables)
        
        self.currentTeam.$team.sink { team in
            self.team = team
        } .store(in: &cancellables)
    }
}
