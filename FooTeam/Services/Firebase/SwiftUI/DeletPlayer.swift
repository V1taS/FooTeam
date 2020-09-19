//
//  DeletPlayer.swift
//  FooTeam
//
//  Created by Виталий Сосин on 11.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import Foundation
import Firebase

class DeletPlayer {
    
    static let shared = DeletPlayer()
    
    private let db = Firestore.firestore()
    
    // MARK: - Delet Player
    func deletPlayerInTeam(player: Player) {
        
        let usersRef = db.collection("players")
        
        usersRef.whereField("uid", isEqualTo: player.id).getDocuments() { (querySnapshot, err) in
          if let err = err {
            print("Error getting documents: \(err)")
          } else {
            for document in querySnapshot!.documents {
              document.reference.delete()
            }
          }
        }
    }
} // Delet Player
