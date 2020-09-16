//
//  MainScreenViewModel.swift
//  FooTeam
//
//  Created by Виталий Сосин on 16.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import Foundation

protocol MainScreenViewModelProtocol {
    var isPresentedAlertSignOut: Bool { get }
}


class MainScreenViewModel: MainScreenViewModelProtocol, ObservableObject {
    @Published var isPresentedAlertSignOut = false // Настроить логику
}
