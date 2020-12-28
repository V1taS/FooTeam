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
    var cancellables: Set<AnyCancellable> { get }
    
    var nameTeam: String { get }
    var iGo: Bool { get }
    init()
}

class InformationsMainScreenViewModel: InformationsMainScreenViewModelProtocol, ObservableObject {
    @Published var currentUser = CurrentUser()
    @Published var currentTeam = CurrentTeam()
    internal var cancellables = Set<AnyCancellable>()
    
    @Published var nameTeam: String = ""
    @Published var iGo: Bool = false
    
    required init() {
        self.currentUser.$player.sink { player in
            self.iGo = player.iGo
        } .store(in: &cancellables)
        
        self.currentTeam.$team.sink { team in
            self.nameTeam = team.teamName 
        } .store(in: &cancellables)
        
        // Будущее (добавить отображение погоды по названию города)
        //        let currentCity = "Khimki"
        //        let city = currentCity.split(separator: " ").joined(separator: "%20")
        //        self.networkWeather.fetchCurrentWeather(city: city)
        //        self.networkWeather.onCompletion = { [weak self] currentWeather in
        //            guard let self = self else { return }
        //            DispatchQueue.main.async {
        //                self.temperatureString = currentWeather.temperatureString
        //            }
        //        }
    }
}
