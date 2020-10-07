//
//  EditPlayerTwo.swift
//  FooTeam
//
//  Created by Виталий Сосин on 15.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//


import Foundation
import Firebase

class EditPlayerSimple {
    
    static let shared = EditPlayerSimple()
    
    private let db = Firestore.firestore()
    
    // MARK: - Edit Player
    func editPlayerInTeam(player: Player) {
        let usersRef = db.collection("players")
        var player = player
        player.teamNumber = 0

        usersRef.document(player.id).updateData(player.representation) { (error) in }
    }
} // edit Player In Team

