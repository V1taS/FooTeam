//
//  EditPlayerTwo.swift
//  FooTeam
//
//  Created by Виталий Сосин on 15.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//


import Foundation
import Firebase

class EditPlayerTwo {
    
    static let shared = EditPlayerTwo()
    
    private let db = Firestore.firestore()
    
    // MARK: - Edit Player
    func editPlayerInTeam(
        player: Player,
        captain: Bool?
    ) {
        let usersRef = db.collection("players")
        var player = player
        
//        if let name = name { player.name = name }
//        if let email = email { player.email = email }
//        if let whoAreYou = whoAreYou { player.whoAreYou = whoAreYou }
//        if let teamNumber = teamNumber { player.teamNumber = teamNumber }
//        if let payment = payment { player.payment = payment }
//        if let iGo = iGo { player.iGo = iGo }
//        if let subscription = subscription { player.subscription = subscription }
//        if let rating = rating { player.rating = rating }
//        if let position = position { player.position = position }
//        if let numberOfGames = numberOfGames { player.numberOfGames = numberOfGames }
//        if let numberOfGoals = numberOfGoals { player.numberOfGoals = numberOfGoals }
//        if let winGame = winGame { player.winGame = winGame }
//        if let losGame = losGame { player.losGame = losGame }
        if let captain = captain { player.captain = captain }
        
//        if let avatarImage = avatarImage {
//            StorageService.shared.uploadAvaPlayer(photo: avatarImage) { (result) in
//                switch result {
//                case .success(let url): player.avatarStringURL = url.absoluteString
//                case .failure(let error): print(error)
//                }
//            }
//        }

        usersRef.document(player.id).updateData(player.representation) { (error) in }
    }
} // edit Player In Team

