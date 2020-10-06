//
//  CellJoinToTeamViewModel.swift
//  FooTeam
//
//  Created by Виталий Сосин on 21.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import Combine
import FirebaseAuth

protocol CellJoinToTeamViewModelProtocol {
    var currentUser: CurrentUser { get }
    var cancellables: Set<AnyCancellable> { get }

    var isPresented: Bool { get }
    var showAlertAccept: Bool { get }
    var colorText: UIColor { get }
    init()
}

class CellJoinToTeamViewModel: CellJoinToTeamViewModelProtocol, ObservableObject {
    @Published var currentUser = CurrentUser()
    internal var cancellables = Set<AnyCancellable>()

    @Published var isPresented: Bool = false
    @Published var showAlertAccept: Bool = false
    let colorText: UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    
    required init() {
        self.currentUser.$player.sink { player in
            if !player.idTeam.isEmpty {
                self.isPresented = true
            }
        } .store(in: &cancellables)

    }
    
}
