//
//  WaitingForConfirmationViewModel.swift
//  FooTeam
//
//  Created by Виталий Сосин on 25.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import Combine
import FirebaseAuth
import SwiftUI

protocol WaitingForConfirmationViewModelProtocol {
    
}

class WaitingForConfirmationViewModel: WaitingForConfirmationViewModelProtocol, ObservableObject {
    
    @Published var currentUser = CurrentUser()

    private var cancellables = Set<AnyCancellable>()
    
    @Published var downloadAmount: Double = 0.0
    @Published var isPresented: Bool = false
    
    init() {
        self.currentUser.$player.sink { player in
            if !player.idTeam.isEmpty {
                if let user = Auth.auth().currentUser {
                    FirestoreService.shared.getUserData(user: user) { (result) in
                        switch result {
                        case .success(let player):
                            if player.idTeam.isEmpty {
                                let mainContentFooTeam = UIHostingController(rootView: JoinToTeamView())
                                mainContentFooTeam.modalPresentationStyle = .fullScreen
                                UIApplication.shared.windows.first?.rootViewController = mainContentFooTeam
                            } else {
                                let mainContentFooTeam = UIHostingController(rootView: TabViewFooTeam())
                                mainContentFooTeam.modalPresentationStyle = .fullScreen
                                UIApplication.shared.windows.first?.rootViewController = mainContentFooTeam
                            }
                        case .failure(_):
                            UIApplication.shared.windows.first?.rootViewController = AuthViewController()
                        }
                    }
                }
            }
        } .store(in: &cancellables)
    }
}
