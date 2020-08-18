//
//  MUser.swift
//  iChat
//
//  Created by Виталий Сосин on 14.07.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import UIKit
import FirebaseFirestore

struct Players: Hashable, Decodable {
    
    let name: String
    let email: String
    var avatarStringURL: String = ""
    
    let whoAreYou: String
    let id: String
    
    var teamNumber: Int = 0
    var payment: String = ""
    
    var iGo: Bool = false
    var subscription: Bool = false
    
    var rating: Int = 0
    var position: String = "ФРВ"
    
    var numberOfGames: Int = 0
    var numberOfGoals: Int = 0
    
    var winGame: Int = 0
    var losGame: Int = 0
    
    var captain: Bool = false
    var date: Date
    
    init(name: String, email: String, avatarStringURL: String, whoAreYou: String, id: String, teamNumber: Int, payment: String, iGo: Bool, subscription: Bool, rating: Int, position: String, numberOfGames: Int, numberOfGoals: Int, winGame: Int, losGame: Int, captain: Bool) {
        self.name = name
        self.email = email
        self.avatarStringURL = avatarStringURL
        self.whoAreYou = whoAreYou
        self.id = id
        
        self.teamNumber = teamNumber
        self.payment = payment
        self.iGo = iGo
        self.subscription = subscription
        self.rating = rating
        self.position = position
        self.numberOfGames = numberOfGames
        self.numberOfGoals = numberOfGoals
        self.winGame = winGame
        self.losGame = losGame
        self.captain = captain
        self.date = Date()
    }
    
    init?(document: DocumentSnapshot) {
        guard let data = document.data() else { return nil}
        guard let name = data["name"] as? String,
        let email = data["email"] as? String,
        let avatarStringURL = data["avatarStringURL"] as? String,
        let whoAreYou = data["whoAreYou"] as? String,
        let id = data["uid"] as? String,
        
        let teamNumber = data["teamNumber"] as? Int,
        let payment = data["payment"] as? String,
        let iGo = data["iGo"] as? Bool,
        let subscription = data["subscription"] as? Bool,
        let rating = data["rating"] as? Int,
        let position = data["position"] as? String,
        let numberOfGames = data["numberOfGames"] as? Int,
        let numberOfGoals = data["numberOfGoals"] as? Int,
        let winGame = data["winGame"] as? Int,
        let losGame = data["losGame"] as? Int,
        let date = data["date"] as? Date,
        let captain = data["captain"] as? Bool else { return nil }
        
        self.name = name
        self.email = email
        self.avatarStringURL = avatarStringURL
        self.whoAreYou = whoAreYou
        self.id = id
        
        self.teamNumber = teamNumber
        self.payment = payment
        self.iGo = iGo
        self.subscription = subscription
        self.rating = rating
        self.position = position
        self.numberOfGames = numberOfGames
        self.numberOfGoals = numberOfGoals
        self.winGame = winGame
        self.losGame = losGame
        self.captain = captain
        self.date = date
    }
    
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        guard let name = data["name"] as? String,
        let email = data["email"] as? String,
        let avatarStringURL = data["avatarStringURL"] as? String,
        let whoAreYou = data["whoAreYou"] as? String,
        let id = data["uid"] as? String,
        
        
        let teamNumber = data["teamNumber"] as? Int,
        let payment = data["payment"] as? String,
        let iGo = data["iGo"] as? Bool,
        let subscription = data["subscription"] as? Bool,
        let rating = data["rating"] as? Int,
        let position = data["position"] as? String,
        let numberOfGames = data["numberOfGames"] as? Int,
        let numberOfGoals = data["numberOfGoals"] as? Int,
        let winGame = data["winGame"] as? Int,
        let losGame = data["losGame"] as? Int,
        let date = data["date"] as? Date,
        let captain = data["captain"] as? Bool else { return nil }
        
        self.name = name
        self.email = email
        self.avatarStringURL = avatarStringURL
        self.whoAreYou = whoAreYou
        self.id = id
        
        self.teamNumber = teamNumber
        self.payment = payment
        self.iGo = iGo
        self.subscription = subscription
        self.rating = rating
        self.position = position
        self.numberOfGames = numberOfGames
        self.numberOfGoals = numberOfGoals
        self.winGame = winGame
        self.losGame = losGame
        self.captain = captain
        self.date = date
    }
    
    var representation: [String: Any] {
        var rep: [String: Any]
        rep = ["name": name]
        
        rep["email"] = email
        rep["avatarStringURL"] = avatarStringURL
        rep["whoAreYou"] = whoAreYou
        rep["uid"] = id
        
        rep["teamNumber"] = teamNumber
        rep["payment"] = payment
        rep["iGo"] = iGo
        rep["subscription"] = subscription
        rep["rating"] = rating
        rep["position"] = position
        rep["numberOfGames"] = numberOfGames
        rep["numberOfGoals"] = numberOfGoals
        rep["winGame"] = winGame
        rep["losGame"] = losGame
        rep["captain"] = captain
        rep["date"] = date
        return rep
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Players, rhs: Players) -> Bool {
        return lhs.id == rhs.id
    }
    
    func contains(filter: String?) -> Bool {
        guard let filter = filter else { return true }
        if filter.isEmpty { return true }
        let lowercasedFilter = filter.lowercased()
        return name.lowercased().contains(lowercasedFilter)
    }
}
