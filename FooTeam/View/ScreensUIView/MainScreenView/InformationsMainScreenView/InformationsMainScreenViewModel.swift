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
    var nameTeam: String { get }
    var iGo: Bool { get }
    var temperatureString: String { get }
    var datePlay: String { get }
}

class InformationsMainScreenViewModel: InformationsMainScreenViewModelProtocol, ObservableObject {
    
    @Published var currentUser = CurrentUser()
    @Published var currentTeam = CurrentTeam()
    @Published var networkWeather = NetworkWeatherManager()
    @Published var calendarFooTeam = CalendarFooTeam()
    
    private var cancellables = Set<AnyCancellable>()

    @Published var nameTeam: String = ""
    @Published var iGo: Bool = false
    @Published var temperatureString: String = ""
    @Published var datePlay: String = ""

    init() {
        
        self.currentUser.$player.sink { player in
            self.iGo = player.iGo
            } .store(in: &cancellables)
        
        self.networkWeather.$weather.sink { weather in
            self.temperatureString = weather.first?.temperatureString ?? ""
        } .store(in: &cancellables)
        
        self.currentTeam.$team.sink { team in
            self.nameTeam = team.teamName ?? ""
            } .store(in: &cancellables)

        self.datePlay = calendarFooTeam.datePlay
    }
}
