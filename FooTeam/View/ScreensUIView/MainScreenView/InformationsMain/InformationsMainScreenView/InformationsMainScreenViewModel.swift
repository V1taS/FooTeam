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
    var currentUser: CurrentUser { get }
    var currentTeam: CurrentTeam { get }
    var networkWeather: NetworkWeatherManager { get }
    var calendarFooTeam: CalendarFooTeam { get }
    var cancellables: Set<AnyCancellable> { get }
    
    var nameTeam: String { get }
    var iGo: Bool { get }
    var temperatureString: String { get }
    var datePlay: String { get }
    init()
}

class InformationsMainScreenViewModel: InformationsMainScreenViewModelProtocol, ObservableObject {
    @Published var currentUser = CurrentUser()
    @Published var currentTeam = CurrentTeam()
    @Published var networkWeather = NetworkWeatherManager()
    @Published var calendarFooTeam = CalendarFooTeam()
    @Published var getTeamPlayTime = GetTeamPlayTime()
    internal var cancellables = Set<AnyCancellable>()
    
    @Published var getPlayTime: [TeamTime] = []
    
    @Published var nameTeam: String = ""
    @Published var iGo: Bool = false
    @Published var temperatureString: String = ""
    @Published var datePlay: String = ""
    
    required init() {
        self.getTeamPlayTime.$teams.sink { dates in
            self.getPlayTime = dates
            } .store(in: &cancellables)
        
        self.currentUser.$player.sink { player in
            self.iGo = player.iGo
        } .store(in: &cancellables)

        let currentCity = "Khimki"
        let city = currentCity.split(separator: " ").joined(separator: "%20")
        self.networkWeather.fetchCurrentWeather(city: city)
        self.networkWeather.onCompletion = { [weak self] currentWeather in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.temperatureString = currentWeather.temperatureString
            }
        }
        
        self.currentTeam.$team.sink { team in
            self.nameTeam = team.teamName 
        } .store(in: &cancellables)
        
        self.datePlay = calendarFooTeam.datePlay
    }
}
