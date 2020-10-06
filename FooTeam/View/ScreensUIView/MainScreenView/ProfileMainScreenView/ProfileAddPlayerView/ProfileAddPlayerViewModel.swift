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
    let whoAreYou = ["Игрок", "Зритель"]
    
    @Published var selectionPositions = 0
    let positions = ["ФРВ", "ЦП", "ЦЗ", "ВРТ"]
    
    @Published var team: Team = Team(
        avatarStringURL: "",
        teamName: "",
        location: "",
        teamType: "",
        rating: 0
    )
    
    required init() {
        self.currentTeam.$team.sink { team in
            self.team = team
        } .store(in: &cancellables)
    }
}
