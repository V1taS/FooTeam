//
//  Players.swift
//  FooTeam
//
//  Created by Виталий Сосин on 14.07.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import UIKit
import Firebase

struct Player: Hashable, Decodable {
    
    var name: String
    
    var email: String
    var avatarStringURL: String
    
    var whoAreYou: String
    var id: String
    var idTeam: String
    
    var teamNumber: Int
    var payment: String
    
    var iGo: Bool
    var subscription: Bool
    
    var rating: Int
    var position: String
    
    var numberOfGoals: Int
    
    var winGame: Int
    var losGame: Int
    
    var captain: Bool
    
    init(name: String, email: String, avatarStringURL: String, whoAreYou: String, id: String, idTeam: String, teamNumber: Int, payment: String, iGo: Bool, subscription: Bool, rating: Int, position: String, numberOfGoals: Int, winGame: Int, losGame: Int, captain: Bool) {
        self.name = name
        self.email = email
        self.avatarStringURL = avatarStringURL
        self.whoAreYou = whoAreYou
        self.id = id
        self.idTeam = idTeam
        
        self.teamNumber = teamNumber
        self.payment = payment
        self.iGo = iGo
        self.subscription = subscription
        self.rating = rating
        self.position = position
        self.numberOfGoals = numberOfGoals
        self.winGame = winGame
        self.losGame = losGame
        self.captain = captain
    }
    
    init?(document: DocumentSnapshot) {
        guard let data = document.data() else { return nil}
        guard let name = data["name"] as? String,
            let email = data["email"] as? String,
            let avatarStringURL = data["avatarStringURL"] as? String,
            let whoAreYou = data["whoAreYou"] as? String,
            let id = data["uid"] as? String,
            let idTeam = data["idTeam"] as? String,
            
            let teamNumber = data["teamNumber"] as? Int,
            let payment = data["payment"] as? String,
            let iGo = data["iGo"] as? Bool,
            let subscription = data["subscription"] as? Bool,
            let rating = data["rating"] as? Int,
            let position = data["position"] as? String,
            let numberOfGoals = data["numberOfGoals"] as? Int,
            let winGame = data["winGame"] as? Int,
            let losGame = data["losGame"] as? Int,
            let captain = data["captain"] as? Bool else { return nil }
        
        self.name = name
        self.email = email
        self.avatarStringURL = avatarStringURL
        self.whoAreYou = whoAreYou
        self.id = id
        self.idTeam = idTeam
        
        self.teamNumber = teamNumber
        self.payment = payment
        self.iGo = iGo
        self.subscription = subscription
        self.rating = rating
        self.position = position
        self.numberOfGoals = numberOfGoals
        self.winGame = winGame
        self.losGame = losGame
        self.captain = captain
    }
    
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        guard let name = data["name"] as? String,
            let email = data["email"] as? String,
            let avatarStringURL = data["avatarStringURL"] as? String,
            let whoAreYou = data["whoAreYou"] as? String,
            let id = data["uid"] as? String,
            let idTeam = data["idTeam"] as? String,
            
            
            let teamNumber = data["teamNumber"] as? Int,
            let payment = data["payment"] as? String,
            let iGo = data["iGo"] as? Bool,
            let subscription = data["subscription"] as? Bool,
            let rating = data["rating"] as? Int,
            let position = data["position"] as? String,
            let numberOfGoals = data["numberOfGoals"] as? Int,
            let winGame = data["winGame"] as? Int,
            let losGame = data["losGame"] as? Int,
            let captain = data["captain"] as? Bool else { return nil }
        
        self.name = name
        self.email = email
        self.avatarStringURL = avatarStringURL
        self.whoAreYou = whoAreYou
        self.id = id
        self.idTeam = idTeam
        
        self.teamNumber = teamNumber
        self.payment = payment
        self.iGo = iGo
        self.subscription = subscription
        self.rating = rating
        self.position = position
        self.numberOfGoals = numberOfGoals
        self.winGame = winGame
        self.losGame = losGame
        self.captain = captain
    }
    
    var representation: [String: Any] {
        var rep: [String: Any]
        rep = ["name": name]
        
        rep["email"] = email
        rep["avatarStringURL"] = avatarStringURL
        rep["whoAreYou"] = whoAreYou
        rep["uid"] = id
        rep["idTeam"] = idTeam
        
        rep["teamNumber"] = teamNumber
        rep["payment"] = payment
        rep["iGo"] = iGo
        rep["subscription"] = subscription
        rep["rating"] = rating
        rep["position"] = position
        rep["numberOfGoals"] = numberOfGoals
        rep["winGame"] = winGame
        rep["losGame"] = losGame
        rep["captain"] = captain
        return rep
    }
    
    var representationPlayer: [String: Any] {
        var rep: [String: Any]
        rep = ["uid": id]
        return rep
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Player, rhs: Player) -> Bool {
        return lhs.id == rhs.id
    }
    
    func contains(filter: String?) -> Bool {
        guard let filter = filter else { return true }
        if filter.isEmpty { return true }
        let lowercasedFilter = filter.lowercased()
        return name.lowercased().contains(lowercasedFilter)
    }
}
