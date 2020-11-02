//
//  CurrentTeam.swift
//  FooTeam
//
//  Created by Виталий Сосин on 14.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth

class CurrentTeam: ObservableObject {
    
    @Published var team = Team(avatarStringURL: "", teamName: "", location: "", teamType: "", rating: 0, maxCountPlayersInTeam: 18, isHidden: true, currentCountPlayersInTeam: 18)
    
    private let db = Firestore.firestore()
    
    init() {
        downloadTeam()
    }
    
    func downloadTeam() {
        
        let teamRef = db.collection("teams")
        
        if let currentUserId = FirestoreService.shared.currentUser {
            teamRef.whereField("id", isEqualTo: currentUserId.idTeam).addSnapshotListener() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        if let team = Team(document: document) {
                            self.team = team
                        }
                    }
                }
            }
        }
    }
}

