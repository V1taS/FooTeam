//
//  EditPlayer.swift
//  FooTeam
//
//  Created by Виталий Сосин on 11.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth

class EditPlayer {
    static let shared = EditPlayer()
    
    // MARK: - Редактирование игрока
    func editPlayerInTeam(
        player: Player,
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
        var player = player
        
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
            StorageService.shared.uploadAvaPlayer(photo: avatarImage, idPlayer: player.id) { (result) in
                switch result {
                case .success(let url): player.avatarStringURL = url.absoluteString
                case .failure(let error): print(error)
                }
            }
        }
        FirebaseReference(.players).document(player.id).updateData(player.representation) { (error) in }
    }
}

class AddPlayer {
    static let shared = AddPlayer()
    private let db = Firestore.firestore()
    
    // MARK: - Ручное добавление игрока в команду
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
        let refActionsPlayer = db.collection(["teams", capitanPlayer.idTeam, "actionsPlayers"].joined(separator: "/"))
        var player = DefaultPlayer.shared.player
        
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
            StorageService.shared.uploadAvaPlayer(photo: avatarImage, idPlayer: player.id) { (result) in
                switch result {
                case .success(let url): player.avatarStringURL = url.absoluteString
                case .failure(let error): print(error)
                }
            }
        }
        FirebaseReference(.players).document(player.id).setData(player.representation) { (error) in }
        refActionsPlayer.document(player.id).setData(player.representationPlayer) { (error) in }
    }
}


class EditPlayerNumberTeam {
    static let shared = EditPlayerNumberTeam()

    // MARK: - Редактируем только номер команды
    func editPlayerInTeam(player: Player, teamNumber: Int) {
        var player = player
        player.teamNumber = teamNumber

        FirebaseReference(.players).document(player.id).updateData(player.representation) { (error) in }
    }
}

class EditPlayerAva {
    static let shared = EditPlayerAva()
    
    // MARK: - Редактируем только аватарку игрока
    func editPlayerInTeam(
        player: Player,
        avatarUIImage: UIImage?
    ) {
        var player = player
        
        if let avatarImage = avatarUIImage {
            StorageService.shared.uploadAvaPlayer(photo: avatarImage, idPlayer: player.id) { (result) in
                switch result {
                case .success(let url):
                    player.avatarStringURL = url.absoluteString
                    FirebaseReference(.players).document(player.id).updateData(player.representation) { (error) in }
                case .failure(let error): print(error)
                }
            }
        }
    }
}

class DeletPlayer {
    static let shared = DeletPlayer()
    
    // MARK: - Удалить игрока
    func deletPlayerInTeam(playerID: String) {
        FirebaseReference(.players).whereField("uid", isEqualTo: playerID).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    document.reference.delete()
                }
            }
        }
    }
}

class DeletePlayerFromTeam {
    static let shared = DeletePlayerFromTeam()
    private let db = Firestore.firestore()
    
    // MARK: - Удалить игрока из команды
    func deletPlayerFromTeam(player: Player) {
        var player = player
        let refActionsPlayer = db.collection(["teams", player.idTeam, "actionsPlayers"].joined(separator: "/"))
        
        refActionsPlayer.whereField("uid", isEqualTo: player.id).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    document.reference.delete()
                }
            }
        }
        player.idTeam = ""
        player.captain = false
        FirebaseReference(.players).document(player.id).updateData(player.representation) { (error) in }
    }
}

class DefaultPlayer {
    static let shared = DefaultPlayer()
    
    // MARK: Значения по умолчанию
    let player = Player(
        name: "",
        email: "",
        avatarStringURL: "",
        whoAreYou: "",
        id: "",
        idTeam: "",
        teamNumber: 0,
        payment: "",
        iGo: false,
        subscription: false,
        rating: 0,
        position: "",
        numberOfGoals: 0,
        winGame: 0,
        losGame: 0,
        captain: false
    )
}
