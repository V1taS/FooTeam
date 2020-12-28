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
    
    // MARK: Удаляем игрока из коллекции waitingPlayers определеной команды и добавляем в actionsPlayers
    func acceptInvitation(player: Player, capitanPlayer: Player) {
        let refWaitingPlayer = db.collection(["teams", capitanPlayer.idTeam, "waitingPlayers"].joined(separator: "/"))
        let refActionsPlayer = db.collection(["teams", capitanPlayer.idTeam, "actionsPlayers"].joined(separator: "/"))
        var player = player
        player.idTeam = capitanPlayer.idTeam
        player.teamNumber = 77
        
        FirebaseReference(.players).document(player.id).updateData(player.representation) { (error) in }
        
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
}

class NoAcceptInvitation {
    static let shared = NoAcceptInvitation()
    private let db = Firestore.firestore()
    
    // MARK: Удаляем игрока из коллекции waitingPlayers определеной команды
    func noAcceptInvitation(player: Player, idTeam: String) {
        let refWaitingPlayer = db.collection(["teams", idTeam, "waitingPlayers"].joined(separator: "/"))
        var player = player
        player.iGo.toggle()
        player.teamNumber = 13
        
        FirebaseReference(.players).document(player.id).updateData(player.representation) { (error) in }
        
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
    }
}

class JoinTheTeam {
    static let shared = JoinTheTeam()
    private let db = Firestore.firestore()
    
    // MARK: Перемещаем игрока в определенную команду в коллекцию waitingPlayers
    func joinToTeam(player: Player, team: Team) {
        let refWaitingPlayer = db.collection(["teams", team.id, "waitingPlayers"].joined(separator: "/"))
        refWaitingPlayer.document(player.id).setData(player.representationPlayer) { (error) in }
    }
}
