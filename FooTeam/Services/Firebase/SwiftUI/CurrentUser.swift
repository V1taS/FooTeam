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
    
    @Published var player = Player(name: "Default player", nameTeam: "", email: "", avatarStringURL: "", whoAreYou: "", id: "", idTeam: "", teamNumber: 0, payment: "", iGo: false, subscription: false, rating: 0, position: "", numberOfGames: 0, numberOfGoals: 0, winGame: 0, losGame: 9, captain: false)
    
    private let db = Firestore.firestore()
    
    private var currentUserId = FirestoreService.shared.currentUser
    
    init() {
        downloadPlayers()
    }
    
    func downloadPlayers() {
        
        let usersRef = db.collection("players")
        
        usersRef.whereField("uid", isEqualTo: currentUserId!.id).addSnapshotListener() { (querySnapshot, err) in
            
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    if let playerNew = Player(document: document) {
                        self.player = playerNew
                    }
                }
            }
        }
    }
}

