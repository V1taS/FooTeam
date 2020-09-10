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
    
    // MARK: - Accept Invitation
    func acceptInvitation(player: Players, team: Teams) {
        
        let refWaitingPlayer = db.collection(["teams", team.id, "waitingPlayers"].joined(separator: "/"))
        let refActionsPlayer = db.collection(["teams", team.id, "actionsPlayers"].joined(separator: "/"))
        
        var player = player
        
        player.idTeam = team.id
        player.nameTeam = team.teamName ?? ""
        
        db.collection("players").document(player.id).setData(player.representation) { (error) in }
        
        refWaitingPlayer.whereField("uid", isEqualTo: player.id).getDocuments() { (querySnapshot, err) in
          if let err = err {
            print("Error getting documents: \(err)")
          } else {
            for document in querySnapshot!.documents {
              document.reference.delete()
            }
          }
        }
        
        refActionsPlayer.document(player.id).setData(player.representationPlayer) { (error) in }
    }
} // Accept Invitation
