//
//  ProfileAddPlayerViewModel.swift
//  FooTeam
//
//  Created by Виталий Сосин on 16.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import Foundation
import Combine

protocol ProfileAddPlayerViewModelProtocol {
    var currentTeam: CurrentTeam { get }
    var cancellables: Set<AnyCancellable> { get }
    
    var name: String { get }
    var email: String { get }
    var payment: String { get }
    
    var selectionWhoAreYou: Int { get }
    var whoAreYou: [String] { get }
    
    var selectionPositions: Int { get }
    var positions: [String] { get }
    
    var team: Team { get }
    init()
}

class ProfileAddPlayerViewModel: ProfileAddPlayerViewModelProtocol, ObservableObject {
    @Published var currentTeam = CurrentTeam()
    internal var cancellables = Set<AnyCancellable>()
    
    @Published var name = ""
    @Published var email = ""
    @Published var payment = "0"
    
    @Published var selectionWhoAreYou = 0
    let whoAreYou = [
        NSLocalizedString("ProfileAddPlayerViewAddWhoAreYouPlayer",
                          comment: "Player"),
        NSLocalizedString("ProfileAddPlayerViewAddWhoAreYouViewer",
                          comment: "Viewer")
    ]
    
    @Published var selectionPositions = 0
    let positions = [NSLocalizedString("SetupProfileViewControllerPositionSt",
                                       comment: "ST"),
                     NSLocalizedString("SetupProfileViewControllerPositionMC",
                                       comment: "MC"),
                     NSLocalizedString("SetupProfileViewControllerPositionDC",
                                       comment: "DC"),
                     NSLocalizedString("SetupProfileViewControllerPositionGK",
                                       comment: "GK")]
    
    @Published var team: Team = DefaultTeam.shared.team
    
    required init() {
        self.currentTeam.$team.sink { team in
            self.team = team
        } .store(in: &cancellables)
    }
}
