//
//  EditTeamAva.swift
//  FooTeam
//
//  Created by Виталий Сосин on 05.11.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import Foundation
import Firebase

class EditTeamAva {
    
    static let shared = EditTeamAva()
    
    private let db = Firestore.firestore()
    
    // MARK: - Edit Player
    func editPlayerInTeam(
        team: Team,
        avatarUIImage: UIImage?
    ) {
        let usersRef = db.collection("teams")
        var team = team
        
        if let avatarImage = avatarUIImage {
            StorageService.shared.uploadAvaTeam(photo: avatarImage, idTeam: team.id) { (result) in
                switch result {
                case .success(let url):
                    team.avatarStringURL = url.absoluteString
                    usersRef.document(team.id).updateData(team.representation) { (error) in }
                case .failure(let error): print(error)
                }
            }
        }   
    }
} // edit Player In Team
