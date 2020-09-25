//
//  CurrentUser.swift
//  FooTeam
//
//  Created by Виталий Сосин on 11.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth

class CurrentUser: ObservableObject {
    
    @Published var player = Player(name: "Default player", email: "", avatarStringURL: "", whoAreYou: "", id: "", idTeam: "", teamNumber: 0, payment: "", iGo: false, subscription: false, rating: 0, position: "", numberOfGames: 0, numberOfGoals: 0, winGame: 0, losGame: 9, captain: false)
    
    private let db = Firestore.firestore()
    
    init() {
        downloadPlayers()
    }
    
    func downloadPlayers() {
        
        let usersRef = db.collection("players")
        
        if let currentUserId = Auth.auth().currentUser?.uid {
            usersRef.whereField("uid", isEqualTo: currentUserId).addSnapshotListener() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        if let player = Player(document: document) {
                            self.player = player
                        }
                    }
                }
            }
        }
        
    }
}

