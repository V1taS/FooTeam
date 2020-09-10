//
//  DeletTeam.swift
//  FooTeam
//
//  Created by Виталий Сосин on 11.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import Foundation
import Firebase

class DeletTeam {
    
    static let shared = DeletTeam()
    
    private let db = Firestore.firestore()
    
    // MARK: - delet Team In Team
    func deletTeamInTeam(team: Teams) {
        
        let usersRef = db.collection("teams")
        
        usersRef.whereField("uid", isEqualTo: team.id).getDocuments() { (querySnapshot, err) in
          if let err = err {
            print("Error getting documents: \(err)")
          } else {
            for document in querySnapshot!.documents {
              document.reference.delete()
            }
          }
        }
    }
} // delet Team In Team
