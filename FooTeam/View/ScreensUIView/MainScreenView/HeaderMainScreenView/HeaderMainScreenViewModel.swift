//
//  HeaderMainScreenViewModel.swift
//  FooTeam
//
//  Created by Виталий Сосин on 16.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import Foundation

protocol HeaderMainScreenViewModelProtocol {
    var getBalance: String { get }
    func fetchBalance()
}

class HeaderMainScreenViewModel: HeaderMainScreenViewModelProtocol, ObservableObject {
    @Published var getBalance: String = ""
    
    func fetchBalance() {
        self.getBalance = FirestoreService.shared.currentUser.payment
    }
}
