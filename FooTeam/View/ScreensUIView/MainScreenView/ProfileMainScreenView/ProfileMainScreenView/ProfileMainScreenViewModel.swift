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
    var currentUser: CurrentUser { get }
    var cancellables: Set<AnyCancellable> { get }
    
    var name: String { get }
    var avatarStringURL: String { get }
    var isPresentedShowModal: Bool { get }
    init()
}

class ProfileMainScreenViewModel: ProfileMainScreenViewModelProtocol, ObservableObject {
    
    @Published var currentUser = CurrentUser()
    internal var cancellables = Set<AnyCancellable>()
    
    @Published var isPresentedShowModal: Bool = false
    @Published var name: String = ""
    @Published var avatarStringURL: String = ""
    
    required init() {
        self.currentUser.$player.sink { player in
            self.name = player.name
            self.avatarStringURL = player.avatarStringURL
        }
        .store(in: &cancellables)
    }
}
