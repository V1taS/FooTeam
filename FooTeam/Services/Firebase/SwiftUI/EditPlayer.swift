//
//  EditPlayer.swift
//  FooTeam
//
//  Created by Виталий Сосин on 11.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import Foundation
import Firebase

class EditPlayer {
    
    static let shared = EditPlayer()
    
    private let db = Firestore.firestore()
    
    // MARK: - Edit Player
    func editPlayerInTeam(
        player: Player,
        players: [Player],
        name: String?,
        avatarImage: UIImage?,
        email: String?,
        whoAreYou: String?,
        teamNumber: Int?,
        payment: String?,
        iGo: Bool?,
        subscription: Bool?,
        rating: Int?,
        position: String?,
        numberOfGoals: Int?,
        winGame: Int?,
        losGame: Int?,
        captain: Bool?
    ) {
        let usersRef = db.collection("players")
        var player = player
        var players = players
        
        if let name = name { player.name = name }
        if let email = email { player.email = email }
        if let whoAreYou = whoAreYou { player.whoAreYou = whoAreYou }
        if let teamNumber = teamNumber { player.teamNumber = teamNumber }
        if let payment = payment { player.payment = payment }
        if let iGo = iGo { player.iGo = iGo }
        if let subscription = subscription { player.subscription = subscription }
        if let rating = rating { player.rating = rating }
        if let position = position { player.position = position }
        if let numberOfGoals = numberOfGoals { player.numberOfGoals = numberOfGoals }
        if let winGame = winGame { player.winGame = winGame }
        if let losGame = losGame { player.losGame = losGame }
        if let captain = captain { player.captain = captain }
        
        if let avatarImage = avatarImage {
            StorageService.shared.uploadAvaPlayer(photo: avatarImage) { (result) in
                switch result {
                case .success(let url): player.avatarStringURL = url.absoluteString
                case .failure(let error): print(error)
                }
            }
        }
        
        usersRef.addSnapshotListener { (querySnapshot, error) in
            guard let snapshot = querySnapshot else { return }
            
            snapshot.documentChanges.forEach { (diff) in
                guard let player = Player(document: diff.document) else { return }
                switch diff.type {
                case .added:
                    guard !players.contains(player) else { return }
                    if let currentUserId = Auth.auth().currentUser?.uid {
                        guard player.id != currentUserId else { return }
                    }
                    players.append(player)
                case .modified:
                    guard let index = players.firstIndex(of: player) else { return }
                    players[index] = player
                case .removed:
                    guard let index = players.firstIndex(of: player) else { return }
                    players.remove(at: index)
                }
            }
        }
        
        
        
        usersRef.document(player.id).updateData(player.representation) { (error) in }
    }
} // edit Player In Team
