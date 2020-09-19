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
    var balance: String { get }
}

class HeaderMainScreenViewModel: HeaderMainScreenViewModelProtocol, ObservableObject {
    
    @Published var currentUser = CurrentUser()
    private var cancellables = Set<AnyCancellable>()
    
    @Published var balance: String = ""
    
    init() {
        self.currentUser.$player.sink { player in
            self.balance = player.payment
            }
            .store(in: &cancellables)
    }
}
