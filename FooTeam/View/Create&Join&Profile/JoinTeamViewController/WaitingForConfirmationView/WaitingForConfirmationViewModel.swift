//
//  WaitingForConfirmationViewModel.swift
//  FooTeam
//
//  Created by Виталий Сосин on 25.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import Combine
import FirebaseAuth

protocol WaitingForConfirmationViewModelProtocol {
    
}

class WaitingForConfirmationViewModel: WaitingForConfirmationViewModelProtocol, ObservableObject {
    
    @Published var currentUser = CurrentUser()
    private var cancellables = Set<AnyCancellable>()
    
    @Published var downloadAmount: Double = 0.0
    @Published var isPresented: Bool = false
    
    init() {

        self.currentUser.$player.sink { player in
            if player.idTeam == "" {
                self.isPresented = false
                FirestoreService.shared.getUserData(user: Auth.auth().currentUser!) { _ in }
            } else {
                FirestoreService.shared.getUserData(user: Auth.auth().currentUser!) { _ in }
                self.isPresented = true
            }
        } .store(in: &cancellables)
    }
}
