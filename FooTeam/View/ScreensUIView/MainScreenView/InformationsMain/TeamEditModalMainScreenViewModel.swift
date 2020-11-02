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
    var cancellables: Set<AnyCancellable> { get }
    
    var isPresentedChangeAvatar: Bool { get }
    
    var players: [Player] { get }
    var team: Team { get }
    var deleteTeam: Bool { get }
    
    var availabilityTeamType: [String] { get }
    var selectionAvailabilityTeamType: Int { get }
    
    var gameInWeak: [String] { get }
    var selectionGameInWeak: Int { get }
    
    var weekday: [[String]] { get }
    var selectionWeekday: [Int] { get }

    var image: UIImage { get }
    init()
}

class TeamEditModalMainScreenViewModel: TeamEditModalMainScreenViewModelProtocol, ObservableObject {
    @Published var actionsPlayers = ActionsPlayers()
    @Published var currentTeam = CurrentTeam()
    @Published var getTeamPlayTime = GetTeamPlayTime()
    internal var cancellables = Set<AnyCancellable>()
    
    @Published var isPresentedChangeAvatar: Bool = false
    @Published var deleteTeam: Bool = false
    
    @Published var players: [Player] = []

    @Published var team: Team = Team(
        avatarStringURL: "",
        teamName: "",
        location: "",
        teamType: "",
        rating: 0,
        maxCountPlayersInTeam: 18,
        isHidden: true,
        currentCountPlayersInTeam: 18
    )
    
    var availabilityTeamType: [String] = ["Открытая", "Закрытая"]
    @Published var selectionAvailabilityTeamType: Int = 0
    
    var gameInWeak: [String] = ["1", "2", "3", "4", "5", "6", "7"]
    @Published var selectionGameInWeak: Int = 0
    
    var weekday: [[String]] = [
        ["Понедельник", "Вторник", "Среда", "Четверг", "Пятница", "Суббота", "Воскресенье"],
        ["Понедельник", "Вторник", "Среда", "Четверг", "Пятница", "Суббота", "Воскресенье"],
        ["Понедельник", "Вторник", "Среда", "Четверг", "Пятница", "Суббота", "Воскресенье"],
        ["Понедельник", "Вторник", "Среда", "Четверг", "Пятница", "Суббота", "Воскресенье"],
        ["Понедельник", "Вторник", "Среда", "Четверг", "Пятница", "Суббота", "Воскресенье"],
        ["Понедельник", "Вторник", "Среда", "Четверг", "Пятница", "Суббота", "Воскресенье"],
        ["Понедельник", "Вторник", "Среда", "Четверг", "Пятница", "Суббота", "Воскресенье"]
    ]
    @Published var selectionWeekday: [Int] = [0, 0, 0, 0, 0, 0, 0]
    
    @Published var getPlayTime: [TeamTime] = []
    
    @Published var calendarDetails: [Date] = [Date(), Date(), Date(), Date(), Date(), Date(), Date()]
    
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
            self.players = players
        } .store(in: &cancellables)
        
        self.currentTeam.$team.sink { team in
            switch team.teamType {
            case "Открытая":
                self.selectionAvailabilityTeamType = 0
            case "Закрытая":
                self.selectionAvailabilityTeamType = 1
            default:
                self.selectionAvailabilityTeamType = 0
            }
            self.team = team
        } .store(in: &cancellables)
    }
}


