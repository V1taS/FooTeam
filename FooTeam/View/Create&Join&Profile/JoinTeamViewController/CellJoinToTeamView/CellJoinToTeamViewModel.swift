//
//  CellJoinToTeamViewModel.swift
//  FooTeam
//
//  Created by Виталий Сосин on 21.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import Combine
import FirebaseAuth
import SwiftUI

protocol CellJoinToTeamViewModelProtocol {
    var currentUser: CurrentUser { get }
    var cancellables: Set<AnyCancellable> { get }

    var isPresented: Bool { get }
    var showAlertAccept: Bool { get }
    init()
}

class CellJoinToTeamViewModel: CellJoinToTeamViewModelProtocol, ObservableObject {
    @Published var currentUser = CurrentUser()
    internal var cancellables = Set<AnyCancellable>()

    @Published var isPresented: Bool = false
    @Published var showAlertAccept: Bool = false
    
    required init() {
        self.currentUser.$player.sink { player in
            
        } .store(in: &cancellables)
    }
    
}
