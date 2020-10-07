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
    var currentUser: CurrentUser { get }
    var cancellables: Set<AnyCancellable> { get }
    
    var downloadAmount: Double { get }
    var isPresented: Bool { get }
    var playerNoAccept: Bool { get }
    init()
}

class WaitingForConfirmationViewModel: WaitingForConfirmationViewModelProtocol, ObservableObject {
    @Published var currentUser = CurrentUser()
    internal var cancellables = Set<AnyCancellable>()
    
    @Published var downloadAmount: Double = 0.0
    @Published var isPresented: Bool = false
    @Published var playerNoAccept: Bool = false
    
    required init() {
        self.currentUser.$player.sink { player in
            if player.teamNumber == 13 {
                self.playerNoAccept = true
                EditPlayerSimple.shared.editPlayerInTeam(player: player)
            }
            if let user = Auth.auth().currentUser {
                FirestoreService.shared.getUserData(user: user) { (result) in
                    switch result {
                    case .success(let player):
                        if !player.idTeam.isEmpty {
                            let mainContentFooTeam = UIHostingController(rootView: TabViewFooTeam())
                            mainContentFooTeam.modalPresentationStyle = .fullScreen
                            UIApplication.shared.windows.first?.rootViewController = mainContentFooTeam
                        }
                    case .failure(_):
                        UIApplication.shared.windows.first?.rootViewController = AuthViewController()
                    }
                }
            }
        } .store(in: &cancellables)
    }
}
