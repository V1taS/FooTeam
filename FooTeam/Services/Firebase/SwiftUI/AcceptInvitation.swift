//
//  AcceptInvitation.swift
//  FooTeam
//
//  Created by Виталий Сосин on 10.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import Foundation
import Firebase

class AcceptInvitation {
    
    static let shared = AcceptInvitation()
    
    private let db = Firestore.firestore()
    
    
    // MARK: Удаляем из режима ОЖИДАНИЯ ПОДТВЕРЖДЕНИЯ игроков текущей команды
    func acceptInvitation(player: Player, capitanPlayer: Player) {
        
        let refWaitingPlayer = db.collection(["teams", capitanPlayer.idTeam, "waitingPlayers"].joined(separator: "/"))
        let refActionsPlayer = db.collection(["teams", capitanPlayer.idTeam, "actionsPlayers"].joined(separator: "/"))
        
        var player = player
        
        player.idTeam = capitanPlayer.idTeam
        player.teamNumber = 77
        
        db.collection("players").document(player.id).updateData(player.representation) { (error) in }
        
        refWaitingPlayer.whereField("uid", isEqualTo: player.id).getDocuments() { (querySnapshot, err) in
            guard let querySnapshot = querySnapshot else { return }
          if let err = err {
            print("Error getting documents: \(err)")
          } else {
            for document in querySnapshot.documents {
              document.reference.delete()
            }
          }
        }
        
        refActionsPlayer.document(player.id).setData(player.representationPlayer) { (error) in }
    }
} // Accept Invitation
