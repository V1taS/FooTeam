//
//  InformationsMainScreenViewModel.swift
//  FooTeam
//
//  Created by Виталий Сосин on 16.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import Foundation

protocol InformationsMainScreenViewModelProtocol {
    var nameTeam: String { get }
    var iGo: Bool { get }
    var temperatureString: String { get }
    var datePlay: String { get }
    
    init(player: CurrentUser)
    init(weather: NetworkWeatherManager)
    init(datePlay: CalendarFooTeam)
}

class InformationsMainScreenViewModel: InformationsMainScreenViewModelProtocol, ObservableObject {

    @Published var nameTeam: String = ""
    
    @Published var iGo: Bool = false
    
    @Published var temperatureString: String = ""
    
    @Published var datePlay: String = ""
    
    required init(player: CurrentUser) {
        player.downloadPlayers()
        
        self.nameTeam = player.player?.nameTeam ?? ""
        self.iGo = player.player?.iGo ?? false
    }
    
    required init(weather: NetworkWeatherManager) {
        temperatureString = "\(weather.weather.first?.temperatureString ?? "")°С"
    }
    
    required init(datePlay: CalendarFooTeam) {
        self.datePlay = "\(datePlay.datePlay)"
    }
}
