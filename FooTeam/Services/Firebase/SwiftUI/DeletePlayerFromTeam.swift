//
//  DeletePlayerFromTeam.swift
//  FooTeam
//
//  Created by Виталий Сосин on 21.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import Foundation
import Firebase

class DeletePlayerFromTeam {
    
    static let shared = DeletePlayerFromTeam()
    
    private let db = Firestore.firestore()
    
    // MARK: - Delete Player From Team
    func deletPlayerFromTeam(player: Player) {
        var player = player
        
        
        let usersRef = db.collection("players")
        let refActionsPlayer = db.collection(["teams", player.idTeam, "actionsPlayers"].joined(separator: "/"))
        
        refActionsPlayer.whereField("uid", isEqualTo: player.id).getDocuments() { (querySnapshot, err) in
          if let err = err {
            print("Error getting documents: \(err)")
          } else {
            for document in querySnapshot!.documents {
              document.reference.delete()
            }
          }
        }
        
        player.idTeam = ""
        player.nameTeam = ""
        
        usersRef.document(player.id).updateData(player.representation) { (error) in }
    }
}


