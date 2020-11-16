//
//  EditPlayerWaitingAccept.swift
//  FooTeam
//
//  Created by Виталий Сосин on 16.11.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import Foundation
import Firebase

class EditPlayerWaitingAccept {
    
    static let shared = EditPlayerWaitingAccept()
    
    private let db = Firestore.firestore()
    
    // MARK: - Edit Player
    func editPlayerInTeam(player: Player, payment: String) {
        let usersRef = db.collection("players")
        var player = player
        player.payment = payment

        usersRef.document(player.id).updateData(player.representation) { (error) in }
    }
} // edit Player In Team
