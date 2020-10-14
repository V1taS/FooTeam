//
//  DeleteCurrentPlayer.swift
//  FooTeam
//
//  Created by Виталий Сосин on 15.10.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import Foundation
import Firebase

class DeleteCurrentPlayer {
    
    static let shared = DeleteCurrentPlayer()
    
    private let db = Firestore.firestore()
    
    // MARK: - Delet Player
    func deletPlayerInTeam(playerID: String) {
        
        let usersRef = db.collection("players")
        
        usersRef.whereField("uid", isEqualTo: playerID).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    document.reference.delete()
                    Auth.auth().currentUser?.delete(completion: { (error) in
                        if let error = error as NSError? {
                            switch AuthErrorCode(rawValue: error.code) {
                            case .operationNotAllowed:
                                print("Email / Password sign in provider is new disabled")
                            case .requiresRecentLogin:
                                print("Updating a user’s password is a security sensitive operation that requires a recent login from the user. This error indicates the user has not signed in recently enough. To resolve, reauthenticate the user by invoking reauthenticateWithCredential:completion: on FIRUser.")
                            default:
                                print("Error message")
                            }
                        } else {
                            print("User account is deleted successfully")
                        }
                    })
                }
            }
        }
    }
} // Delet Player
