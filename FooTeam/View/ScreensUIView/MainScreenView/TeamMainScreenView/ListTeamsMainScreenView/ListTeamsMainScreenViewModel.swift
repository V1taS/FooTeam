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
    var iGoCount: Int { get }
    var countTeams: Int { get }
    
    var temperatureString: String { get }
    var temperatureIcon: String { get }
    var datePlay: String { get }
}

class ListTeamsMainScreenViewModel: ListTeamsMainScreenViewModelProtocol, ObservableObject {

    @Published var actionsPlayers = ActionsPlayers()
    @Published var networkWeather = NetworkWeatherManager()
    @Published var calendarFooTeam = CalendarFooTeam()
    private var cancellables = Set<AnyCancellable>()
    
    @Published var iGoCount: Int = 0 
    @Published var countTeams: Int = 0
    @Published var selectionTeams: Int = 0
    @Published var iGoPlayers: [Player] = []
    
    @Published var temperatureString: String = ""
    @Published var temperatureIcon: String = ""
    
    @Published var datePlay: String = ""

    
    init() {
        self.actionsPlayers.$players.sink { players in
            
            let iGoCount = players.filter { $0.iGo }
            self.iGoPlayers = iGoCount
            self.iGoCount = iGoCount.count
            
        } .store(in: &cancellables)
        
        self.networkWeather.$weather.sink { weather in
            self.temperatureString = weather.first?.temperatureString ?? ""
        } .store(in: &cancellables)

        self.datePlay = calendarFooTeam.datePlay
        
        
    }
}
