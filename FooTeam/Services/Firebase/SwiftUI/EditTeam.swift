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
        teams: [Teams],
        teamName: String?,
        avatarImage: UIImage?,
        location: String?,
        teamType: String?,
        rating: Int?
    ) {
        let teamRef = db.collection("teams")
        var team = team
        var teams = teams
        
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
        
        teamRef.addSnapshotListener { (querySnapshot, error) in
            guard let snapshot = querySnapshot else { return }
            
            snapshot.documentChanges.forEach { (diff) in
                guard let team = Teams(document: diff.document) else { return }
                switch diff.type {
                case .added:
                    guard !teams.contains(team) else { return }
                    teams.append(team)
                case .modified:
                    guard let index = teams.firstIndex(of: team) else { return }
                    teams[index] = team
                case .removed:
                    guard let index = teams.firstIndex(of: team) else { return }
                    teams.remove(at: index)
                }
            }
        }
        
        teamRef.document(team.id).updateData(team.representation) { (error) in }
    }
} // Edit Team
