//
//  ProfileMainScreenViewModel.swift
//  FooTeam
//
//  Created by Виталий Сосин on 16.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import Combine
import SwiftUI

protocol ProfileMainScreenViewModelProtocol {
    var name: String { get }
    var avatarStringURL: String { get }
}

class ProfileMainScreenViewModel: ProfileMainScreenViewModelProtocol, ObservableObject {
    
    @Published var currentUser = CurrentUser()
    private var cancellables = Set<AnyCancellable>()
    
    @Published var name: String = ""
    @Published var avatarStringURL: String = ""

    init() {
        self.currentUser.$player.sink { player in
                self.name = player.name
                self.avatarStringURL = player.avatarStringURL
            }
            .store(in: &cancellables)
    }
}
