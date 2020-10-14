//
//  InformationsMainScreenViewModel.swift
//  FooTeam
//
//  Created by Виталий Сосин on 16.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import Foundation
import Combine

protocol InformationsMainScreenViewModelProtocol {
    var waitingPlayers: WaitingPlayers { get }
    var currentUser: CurrentUser { get }
    var currentTeam: CurrentTeam { get }
    var networkWeather: NetworkWeatherManager { get }
    var calendarFooTeam: CalendarFooTeam { get }
    var cancellables: Set<AnyCancellable> { get }
    
    var nameTeam: String { get }
    var iGo: Bool { get }
    var capitan: Bool { get }
    var temperatureString: String { get }
    var datePlay: String { get }
    init()
}

class InformationsMainScreenViewModel: InformationsMainScreenViewModelProtocol, ObservableObject {
    @Published var waitingPlayers = WaitingPlayers()
    @Published var currentUser = CurrentUser()
    @Published var currentTeam = CurrentTeam()
    @Published var networkWeather = NetworkWeatherManager()
    @Published var calendarFooTeam = CalendarFooTeam()
    internal var cancellables = Set<AnyCancellable>()
    
    @Published var playersWaitingAccept: [Player] = []
    @Published var nameTeam: String = ""
    @Published var iGo: Bool = false
    @Published var capitan: Bool = false
    @Published var temperatureString: String = ""
    @Published var datePlay: String = ""
    
    required init() {
        self.currentUser.$player.sink { player in
            self.iGo = player.iGo
            self.capitan = player.captain
        } .store(in: &cancellables)
        
        self.waitingPlayers.$players.sink { players in
            self.playersWaitingAccept = players
        } .store(in: &cancellables)
        
        self.networkWeather.$weather.sink { weather in
            self.temperatureString = weather.first?.temperatureString ?? ""
        } .store(in: &cancellables)
        
        self.currentTeam.$team.sink { team in
            self.nameTeam = team.teamName 
        } .store(in: &cancellables)
        
        self.datePlay = calendarFooTeam.datePlay
    }
}
