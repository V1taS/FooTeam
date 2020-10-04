//
//  HeaderMainScreenViewModel.swift
//  FooTeam
//
//  Created by Виталий Сосин on 16.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import Foundation
import Combine

protocol HeaderMainScreenViewModelProtocol {
    var currentUser: CurrentUser { get }
    var cancellables: Set<AnyCancellable> { get }
    
    var balance: String { get }
    init()
}

class HeaderMainScreenViewModel: HeaderMainScreenViewModelProtocol, ObservableObject {
    
    @Published var currentUser = CurrentUser()
    internal var cancellables = Set<AnyCancellable>()
    
    @Published var balance: String = ""
    
    required init() {
        self.currentUser.$player.sink { player in
            self.balance = player.payment
            }
            .store(in: &cancellables)
    }
}
