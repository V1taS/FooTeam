//
//  JoinTheTeam.swift
//  FooTeam
//
//  Created by Виталий Сосин on 10.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import Foundation
import Firebase

class JoinTheTeam {
    
    static let shared = JoinTheTeam()
    
    private let db = Firestore.firestore()
    
    // MARK: - Save UID Player In Team
    func SaveIDinTeam(player: Player, team: Team) {
        
        let refWaitingPlayer = db.collection(["teams", team.id, "waitingPlayers"].joined(separator: "/"))
        
        refWaitingPlayer.document(player.id).setData(player.representationPlayer) { (error) in }

    }
} // Save UID Player In Team
