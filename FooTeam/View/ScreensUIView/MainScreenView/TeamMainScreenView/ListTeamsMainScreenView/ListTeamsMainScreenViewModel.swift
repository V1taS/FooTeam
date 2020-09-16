//
//  ListTeamsMainScreenViewModel.swift
//  FooTeam
//
//  Created by Виталий Сосин on 16.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import Foundation

protocol ListTeamsMainScreenViewModelProtocol {
    var countPlayersIgo: Int { get }
    var countTeams: Int { get }
    
    var temperatureString: String { get }
    var datePlay: String { get }
    
    var closeShowModal: Bool { get }
    
    init(players: ActionsPlayers)
    init(weather: NetworkWeatherManager)
    init(datePlay: CalendarFooTeam)
}

class ListTeamsMainScreenViewModel: ListTeamsMainScreenViewModelProtocol, ObservableObject {
    
    @Published var countPlayersIgo: Int = 0
    
    @Published var countTeams: Int = 0 // Настроить логику (алгоритм готовый на почте)
    
    @Published var temperatureString: String = ""
    
    @Published var datePlay: String = ""
    
    @Published var closeShowModal: Bool = false // Настроить логику
    
    required init(players: ActionsPlayers) {
        players.downloadPlayers()
        let playersIgo = players.players.filter { $0.iGo }
        
        self.countPlayersIgo = playersIgo.count
    }
    
    required init(weather: NetworkWeatherManager) {
        temperatureString = "\(weather.weather.first?.temperatureString ?? "")°С"
    }
    
    required init(datePlay: CalendarFooTeam) {
        self.datePlay = "\(datePlay.datePlay)"
    }
    
    
}
