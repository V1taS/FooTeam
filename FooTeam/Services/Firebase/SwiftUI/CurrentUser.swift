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
    
    @Published var player: Players? = nil
    
    private let db = Firestore.firestore()
    
    private var currentUserId: String {
        return Auth.auth().currentUser?.uid ?? ""
    }
    
    init() {
        downloadPlayers()
    }
    
    func downloadPlayers() {
        
        let usersRef = db.collection("players")
        
        usersRef.whereField("uid", isEqualTo: currentUserId).addSnapshotListener() { (querySnapshot, err) in
            
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                
                for document in querySnapshot!.documents {
                    let playerNew = Players(document: document)
                    self.player = playerNew
                }
            }
        }
    }
}
