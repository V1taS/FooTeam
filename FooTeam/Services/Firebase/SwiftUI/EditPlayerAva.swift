//
//  EditPlayerThree.swift
//  FooTeam
//
//  Created by Виталий Сосин on 27.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import Foundation
import Firebase

class EditPlayerAva {
    
    static let shared = EditPlayerAva()
    
    private let db = Firestore.firestore()
    
    // MARK: - Edit Player
    func editPlayerInTeam(
        player: Player,
        avatarUIImage: UIImage?
    ) {
        let usersRef = db.collection("players")
        var player = player
        
        if let avatarImage = avatarUIImage {
            StorageService.shared.uploadAvaPlayer(photo: avatarImage, idPlayer: player.id) { (result) in
                switch result {
                case .success(let url):
                    player.avatarStringURL = url.absoluteString
                    usersRef.document(player.id).updateData(player.representation) { (error) in }
                case .failure(let error): print(error)
                }
            }
        }

        
    }
} // edit Player In Team

