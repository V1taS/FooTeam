//
//  AddPlayer.swift
//  FooTeam
//
//  Created by Виталий Сосин on 11.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import Foundation
import Firebase

class AddPlayer {
    
    static let shared = AddPlayer()
    
    private let db = Firestore.firestore()
    
    // MARK: - Add Player
    func addPlayerWith(
        capitanPlayer: Player,
        avatarImage: UIImage?,
        name: String?,
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
        let refActionsPlayer = db.collection(["teams", capitanPlayer.idTeam, "actionsPlayers"].joined(separator: "/"))
        
        var player = Player(name: "", email: "", avatarStringURL: "", whoAreYou: "", id: "", idTeam: "", teamNumber: 0, payment: "", iGo: false, subscription: false, rating: 0, position: "", numberOfGoals: 0, winGame: 0, losGame: 0, captain: false)
        
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
        
        player.idTeam = capitanPlayer.idTeam
        player.id = UUID().uuidString
        
        if let avatarImage = avatarImage {
            StorageService.shared.uploadAvaPlayer(photo: avatarImage) { (result) in
                switch result {
                case .success(let url): player.avatarStringURL = url.absoluteString
                case .failure(let error): print(error)
                }
            }
        }
        
        usersRef.document(player.id).setData(player.representation) { (error) in }
        refActionsPlayer.document(player.id).setData(player.representationPlayer) { (error) in }
        
    }
    
} // Add Player
