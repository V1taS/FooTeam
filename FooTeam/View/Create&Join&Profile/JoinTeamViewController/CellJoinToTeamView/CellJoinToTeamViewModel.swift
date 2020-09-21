//
//  CellJoinToTeamViewModel.swift
//  FooTeam
//
//  Created by Виталий Сосин on 21.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import Foundation

protocol CellJoinToTeamViewModelProtocol {
    var avatarStringURL: String { get }
    var teamName: String { get }
    var location: String { get }
    var teamType: String { get }
    var rating: String { get }
    
    init(team: Teams)
}

class CellJoinToTeamViewModel: CellJoinToTeamViewModelProtocol, ObservableObject {
    
    @Published var avatarStringURL: String = ""
    @Published var teamName: String = ""
    @Published var location: String = ""
    @Published var teamType: String = ""
    @Published var rating: String = ""
    
    required init(team: Teams) {
        self.avatarStringURL = team.avatarStringURL ?? ""
        self.teamName = team.teamName ?? ""
        self.location = team.location ?? ""
        self.teamType = team.teamType ?? ""
        self.rating = "\(team.rating ?? 0)"
    }
    
}
