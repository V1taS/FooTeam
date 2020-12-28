//
//  MainScreenViewModel.swift
//  FooTeam
//
//  Created by Виталий Сосин on 04.10.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI

protocol MainScreenViewModelProtocol {
    var isPresentedAlertSignOut: Bool { get }
}

class MainScreenViewModel: MainScreenViewModelProtocol, ObservableObject {
    @Published var isPresentedAlertSignOut: Bool = false
}
