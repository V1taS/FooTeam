//
//  RowCalendarforInfoViewModel.swift
//  FooTeam
//
//  Created by Виталий Сосин on 05.11.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI
import Combine

protocol RowCalendarforInfoViewModelProtocol {
    var actionsPlayers: ActionsPlayers { get }
    var currentTeam: CurrentTeam { get }
    var getTeamPlayTime: DatePlayTeam { get }
    var cancellables: Set<AnyCancellable> { get }
    
    var players: [Player] { get }
    var team: Team { get }
    var getPlayTime: [TeamTime] { get }
    var currentWeekday: Int { get }
    
    var monday: Bool { get }
    var tuesday: Bool { get }
    var wednesday: Bool { get }
    var thursday: Bool { get }
    var friday: Bool { get }
    var saturday: Bool { get }
    var sunday: Bool { get }
    init()
}

class RowCalendarforInfoViewModel: RowCalendarforInfoViewModelProtocol, ObservableObject {
    @Published var actionsPlayers = ActionsPlayers()
    @Published var currentTeam = CurrentTeam()
    @Published var getTeamPlayTime = DatePlayTeam()
    internal var cancellables = Set<AnyCancellable>()
    
    @Published var players: [Player] = []
    @Published var team: Team = DefaultTeam.shared.team
    @Published var getPlayTime: [TeamTime] = []
    @Published var currentWeekday: Int = 10
    
    @Published var monday: Bool = false
    @Published var tuesday: Bool = false
    @Published var wednesday: Bool = false
    @Published var thursday: Bool = false
    @Published var friday: Bool = false
    @Published var saturday: Bool = false
    @Published var sunday: Bool = false
    
    required init() {
        self.getTeamPlayTime.$teams.sink { [self] team in
            monday = false
            tuesday = false
            wednesday = false
            thursday = false
            friday = false
            saturday = false
            sunday = false
            
            team.forEach { time in
                switch time.dayOfWeek {
                case "0":
                    monday = true
                case "1":
                    tuesday = true
                case "2":
                    wednesday = true
                case "3":
                    thursday = true
                case "4":
                    friday = true
                case "5":
                    saturday = true
                case "6":
                    sunday = true
                default:
                    print("нет такого дня для календаря")
                }
            }
            
            self.getPlayTime = team
        } .store(in: &cancellables)
        
        self.actionsPlayers.$players.sink { players in
            self.players = players
        } .store(in: &cancellables)
        
        self.currentTeam.$team.sink { team in
            self.team = team
        } .store(in: &cancellables)
    }
}



