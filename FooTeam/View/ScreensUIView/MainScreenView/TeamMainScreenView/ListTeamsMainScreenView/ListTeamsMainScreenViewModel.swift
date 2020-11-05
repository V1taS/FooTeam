//
//  ListTeamsMainScreenViewModel.swift
//  FooTeam
//
//  Created by Виталий Сосин on 16.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import Foundation
import Combine

protocol ListTeamsMainScreenViewModelProtocol {
    var actionsPlayers: ActionsPlayers { get }
    var networkWeather: NetworkWeatherManager { get }
    var calendarFooTeam: CalendarFooTeam { get }
    var cancellables: Set<AnyCancellable> { get }
    
    var iGoCount: Int { get }
    var countTeams: Int { get }
    var selectionTeams: Int { get }
    var iGoPlayers: [Player] { get }
    
    var temperatureString: String { get }
    var datePlay: String { get }
    init()
}

class ListTeamsMainScreenViewModel: ListTeamsMainScreenViewModelProtocol, ObservableObject {
    @Published var actionsPlayers = ActionsPlayers()
    @Published var networkWeather = NetworkWeatherManager()
    @Published var calendarFooTeam = CalendarFooTeam()
    @Published var currentTeam = CurrentTeam()
    internal var cancellables = Set<AnyCancellable>()
    
    @Published var iGoCount: Int = 0 
    @Published var countTeams: Int = 0
    @Published var selectionTeams: Int = 0
    @Published var iGoPlayers: [Player] = []
    
    @Published var temperatureString: String = ""
    @Published var datePlay: String = ""
    
    @Published var team: Team = Team(
        avatarStringURL: "",
        teamName: "",
        location: "",
        teamType: "",
        rating: 0,
        maxCountPlayersInTeam: 18,
        isHidden: false,
        currentCountPlayersInTeam: 18,
        country: "",
        totalMoney: "",
        gameСosts: "",
        fieldType: ""
    )

    required init() {
        self.currentTeam.$team.sink { team in
            self.team = team
        } .store(in: &cancellables)
        
        self.actionsPlayers.$players.sink { players in
            let iGoPlayers = players.filter { $0.iGo }
            self.iGoPlayers = iGoPlayers
            self.iGoCount = iGoPlayers.count
        } .store(in: &cancellables)
        
        self.networkWeather.fetchCurrentWeather(city: "Khimki")
        self.networkWeather.onCompletion = { [weak self] currentWeather in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.temperatureString = currentWeather.temperatureString
            }
        }

        self.datePlay = calendarFooTeam.datePlay
    }
}
