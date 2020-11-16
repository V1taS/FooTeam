//
//  TeamEditModalMainScreenViewModel.swift
//  FooTeam
//
//  Created by Виталий Сосин on 09.10.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI
import Combine

protocol TeamEditModalMainScreenViewModelProtocol {
    var actionsPlayers: ActionsPlayers { get }
    var currentTeam: CurrentTeam { get }
    var getTeamPlayTime: GetTeamPlayTime { get }
    var cancellables: Set<AnyCancellable> { get }
    
    var deleteTeam: Bool { get }
    var players: [Player] { get }
    var team: Team { get }
    
    var availabilityTeamType: [String] { get }
    var selectionAvailabilityTeamType: Int { get }
    
    var gameInWeak: [String] { get }
    var selectionGameInWeak: Int { get }
    
    var weekday: [[String]] { get }
    var selectionWeekday: [Int] { get }
    
    var availabilityFieldType: [String] { get }
    var selectionAvailabilityFieldType: Int { get }
    
    var getPlayTime: [TeamTime] { get }
    var calendarDetails: [Date] { get }
    var rating: Int { get }
    var isPresentedChangeAvatar: Bool { get }
    var image: UIImage { get }
    init()
}

class TeamEditModalMainScreenViewModel: TeamEditModalMainScreenViewModelProtocol, ObservableObject {
    @Published var actionsPlayers = ActionsPlayers()
    @Published var currentTeam = CurrentTeam()
    @Published var getTeamPlayTime = GetTeamPlayTime()
    internal var cancellables = Set<AnyCancellable>()
    
    @Published var deleteTeam: Bool = false
    @Published var players: [Player] = []
    @Published var team: Team = DefaultTeam.shared.team
    
    var availabilityTeamType: [String] = [
        NSLocalizedString("TeamEditModalMainScreenViewModelTeamTypeOpen",
                          comment: "Open"),
        NSLocalizedString("TeamEditModalMainScreenViewModelTeamTypeClose",
                          comment: "Private")
    ]
    @Published var selectionAvailabilityTeamType: Int = 0
    
    var gameInWeak: [String] = ["1", "2", "3", "4", "5", "6", "7"]
    @Published var selectionGameInWeak: Int = 0
    
    var weekday: [[String]] = DataOfDaysOfTheWeek.shared.days
    @Published var selectionWeekday: [Int] = [0, 0, 0, 0, 0, 0, 0]
    
    var availabilityFieldType: [String] = [
        NSLocalizedString("TeamEditModalMainScreenViewModelFieldTypeMini",
                          comment: "Mini"),
        NSLocalizedString("TeamEditModalMainScreenViewModelFieldTypeFull",
                          comment: "Big")
    ]
    @Published var selectionAvailabilityFieldType: Int = 0
    
    @Published var getPlayTime: [TeamTime] = []
    @Published var calendarDetails: [Date] = [Date(),
                                              Date(),
                                              Date(),
                                              Date(),
                                              Date(),
                                              Date(),
                                              Date()]
    @Published var rating: Int = 0
    @Published var isPresentedChangeAvatar: Bool = false
    @Published var image = UIImage()
    
    required init() {
        self.getTeamPlayTime.$teams.sink { team in
            self.getPlayTime = team
            self.selectionGameInWeak = team.count - 1
            
            var index = 0
            for item in team {
                self.calendarDetails.insert(item.date, at: index)
                self.selectionWeekday.insert(Int(item.dayOfWeek) ?? 0, at: index)
                index += 1
            }
            index = 0
            
            } .store(in: &cancellables)
        
        self.actionsPlayers.$players.sink { players in
            var totalRating = 1
            let playersRating = players.filter { $0.winGame > 1 || $0.losGame > 1 }
            playersRating.forEach { player in totalRating += player.rating }
            if !playersRating.isEmpty { self.rating = totalRating / playersRating.count }
            self.players = players
        } .store(in: &cancellables)
        
        self.currentTeam.$team.sink { team in
            switch team.teamType {
            case "0":
                self.selectionAvailabilityTeamType = 0
            case "1":
                self.selectionAvailabilityTeamType = 1
            default:
                self.selectionAvailabilityTeamType = 0
            }
            
            switch team.fieldType {
            case "0":
                self.selectionAvailabilityFieldType = 0
            case "1":
                self.selectionAvailabilityFieldType = 1
            default:
                self.selectionAvailabilityFieldType = 0
            }
            self.team = team
        } .store(in: &cancellables)
    }
}


