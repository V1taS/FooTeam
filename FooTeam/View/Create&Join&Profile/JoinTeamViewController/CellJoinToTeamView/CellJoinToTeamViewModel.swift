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

}

class CellJoinToTeamViewModel: CellJoinToTeamViewModelProtocol, ObservableObject {
    
    @Published var currentUser = CurrentUser()
    private var cancellables = Set<AnyCancellable>()
    
    @Published var downloadAmount: Double = 0.0
    @Published var isPresented: Bool = false
    
    @Published var showAlertAccept: Bool = false
    
    init() {
        
        self.currentUser.$player.sink { player in
            
            if !player.idTeam.isEmpty {
                self.isPresented = true
            }
        } .store(in: &cancellables)

    }
    
}
