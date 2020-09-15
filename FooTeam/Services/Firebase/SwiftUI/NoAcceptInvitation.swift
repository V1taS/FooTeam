//
//  NoAcceptInvitation.swift
//  FooTeam
//
//  Created by Виталий Сосин on 15.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import Foundation
import Firebase

class NoAcceptInvitation {
    
    static let shared = NoAcceptInvitation()
    
    private let db = Firestore.firestore()
    
    
    // MARK: Удаляем из режима ОЖИДАНИЯ ПОДТВЕРЖДЕНИЯ игроков текущей команды
    func acceptInvitation(player: Players, capitanPlayer: Players) {
        
        let refWaitingPlayer = db.collection(["teams", capitanPlayer.idTeam, "waitingPlayers"].joined(separator: "/"))

        db.collection("players").document(player.id).setData(player.representation) { (error) in }
        
        refWaitingPlayer.whereField("uid", isEqualTo: player.id).addSnapshotListener() { (querySnapshot, err) in
          if let err = err {
            print("Error getting documents: \(err)")
          } else {
            for document in querySnapshot!.documents {
              document.reference.delete()
            }
          }
        }
    }
} // Accept Invitation
