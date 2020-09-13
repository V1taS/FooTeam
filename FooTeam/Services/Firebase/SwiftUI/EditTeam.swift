//
//  EditTeam.swift
//  FooTeam
//
//  Created by Виталий Сосин on 11.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import Foundation
import Firebase

class EditTeam {
    
    static let shared = EditTeam()
    
    private let db = Firestore.firestore()
    
    // MARK: - Edit Team
    func editTeamInTeam(
        team: Teams,
        teamName: String?,
        avatarImage: UIImage?,
        location: String?,
        teamType: String?,
        rating: Int?
    ) {
        let teamRef = db.collection("teams")
        var team = team
        
        if let teamName = teamName { team.teamName = teamName }
        if let location = location { team.location = location }
        if let teamType = teamType { team.teamType = teamType }
        if let rating = rating { team.rating = rating }
        
        if let avatarImage = avatarImage {
            StorageService.shared.uploadAvaTeam(photo: avatarImage) { (result) in
                switch result {
                case .success(let url): team.avatarStringURL = url.absoluteString
                case .failure(let error): print(error)
                }
            }
        }
        
        teamRef.document(team.id).setData(team.representation) { (error) in }
    }
} // Edit Team
