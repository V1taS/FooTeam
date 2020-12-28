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

struct AlertIdentifier: Identifiable {
    enum Choice { case first, second }
    var id: Choice
}

protocol WaitingForConfirmationViewModelProtocol {
    var currentUser: CurrentUser { get }
    var currentTeam: CurrentTeam { get }
    var cancellables: Set<AnyCancellable> { get }
    
    var downloadAmount: Double { get }
    var isPresented: Bool { get }
    var playerNoAccept: Bool { get }
    var player: Player { get }
    var team: Team { get }
    var alertIdentifier: AlertIdentifier? { get }
    
    func setTimer()
    init()
}

class WaitingForConfirmationViewModel: WaitingForConfirmationViewModelProtocol, ObservableObject {
    @Published var currentUser = CurrentUser()
    @Published var currentTeam = CurrentTeam()
    internal var cancellables = Set<AnyCancellable>()
    
    @Published var downloadAmount: Double = 0.0
    @Published var isPresented: Bool = false {
        didSet { self.alertIdentifier = AlertIdentifier(id: .second) }
    }
    
    @Published var playerNoAccept: Bool = false {
        didSet { self.alertIdentifier = AlertIdentifier(id: .first) }
    }
    
    @Published var player: Player = DefaultPlayer.shared.player
    @Published var team: Team = DefaultTeam.shared.team
    @Published var alertIdentifier: AlertIdentifier?
    
    func setTimer() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [self] _ in
            if downloadAmount < 100 {
                downloadAmount += 1.1
            } else {
                downloadAmount = 0
            }
        }
    }
    
    required init() {
        self.currentTeam.$team.sink { team in
            self.team = team
        } .store(in: &cancellables)
        
        self.currentUser.$player.sink { player in
            self.player = player
            
            if player.teamNumber == 13 {
                self.playerNoAccept.toggle()
                EditPlayerNumberTeam.shared.editPlayerInTeam(player: player, teamNumber: 0)
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
