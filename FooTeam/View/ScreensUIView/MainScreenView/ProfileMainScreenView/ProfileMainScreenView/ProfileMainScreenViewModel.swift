//
//  ProfileMainScreenViewModel.swift
//  FooTeam
//
//  Created by Виталий Сосин on 16.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import Foundation

protocol ProfileMainScreenViewModelProtocol {
    var isPresentedShowModal: Bool { get }
    var name: String { get }
    var avatarStringURL: String { get }
    init(player: CurrentUser)
    
}

class ProfileMainScreenViewModel: ProfileMainScreenViewModelProtocol, ObservableObject {
    
    @Published var isPresentedShowModal: Bool = false // Настроить логику
    
    @Published var name: String = ""
    
    @Published var avatarStringURL: String = ""
    
    required init(player: CurrentUser) {
        player.downloadPlayers()
        self.name = player.player?.name ?? ""
        self.avatarStringURL = player.player?.avatarStringURL ?? ""
    }
}
