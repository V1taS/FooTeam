//
//  CurrentTeam.swift
//  FooTeam
//
//  Created by Виталий Сосин on 14.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import Foundation
import Firebase

class CurrentTeam {
    
    static let shared = CurrentTeam()
    
    private let db = Firestore.firestore()
    
    // MARK: - Current Team
    func currentTeam(player: Player) -> Teams {

        let teamRef = db.collection("teams")
        var team: Teams?

        teamRef.whereField("uid", isEqualTo: player.idTeam).addSnapshotListener() { (querySnapshot, err) in
            
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                
                for document in querySnapshot!.documents {
                    let teamNew = Teams(document: document)
                    team = teamNew ?? Teams(avatarStringURL: "", teamName: "", location: "", teamType: "", rating: 0)
                }
            }
        }
        return team ?? Teams(avatarStringURL: "", teamName: "", location: "", teamType: "", rating: 0)
    }
} // Current Team

