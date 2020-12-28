//
//  Teams.swift
//  FooTeam
//
//  Created by Виталий Сосин on 10.08.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import UIKit
import Firebase

struct Team: Hashable, Decodable {
    
    var avatarStringURL: String
    var teamName: String
    var location: String
    var teamType: String
    var id: String
    var rating: Int
    var isHidden: Bool
    var maxCountPlayersInTeam: Int
    var currentCountPlayersInTeam: Int
    var country: String
    var totalMoney: String
    var gameСosts: String
    var fieldType: String
    
    init(
        avatarStringURL: String,
        teamName: String,
        location: String,
        teamType: String,
        rating: Int,
        maxCountPlayersInTeam: Int,
        isHidden: Bool,
        currentCountPlayersInTeam: Int,
        country: String,
        totalMoney: String,
        gameСosts: String,
        fieldType: String
    ) {
        self.avatarStringURL = avatarStringURL
        self.teamName = teamName
        self.location = location
        self.teamType = teamType
        self.id = UUID().uuidString
        self.rating = rating
        self.maxCountPlayersInTeam = maxCountPlayersInTeam
        self.isHidden = isHidden
        self.currentCountPlayersInTeam = currentCountPlayersInTeam
        self.country = country
        self.totalMoney = totalMoney
        self.gameСosts = gameСosts
        self.fieldType = fieldType
    }
    
    init?(document: DocumentSnapshot) {
        guard let data = document.data() else { return nil}
        guard let avatarStringURL = data["avatarStringURL"] as? String,
              let teamName = data["teamName"] as? String,
              let location = data["location"] as? String,
              let teamType = data["teamType"] as? String,
              let id = data["id"] as? String,
              let country = data["country"] as? String,
              let totalMoney = data["totalMoney"] as? String,
              let gameСosts = data["gameСosts"] as? String,
              let fieldType = data["fieldType"] as? String,
              let maxCountPlayersInTeam = data["maxCountPlayersInTeam"] as? Int,
              let currentCountPlayersInTeam = data["currentCountPlayersInTeam"] as? Int,
              let isHidden = data["isHidden"] as? Bool,
              let rating = data["rating"] as? Int else { return nil }
        self.avatarStringURL = avatarStringURL
        self.teamName = teamName
        self.location = location
        self.teamType = teamType
        self.rating = rating
        self.maxCountPlayersInTeam = maxCountPlayersInTeam
        self.currentCountPlayersInTeam = currentCountPlayersInTeam
        self.isHidden = isHidden
        self.id = id
        self.country = country
        self.totalMoney = totalMoney
        self.gameСosts = gameСosts
        self.fieldType = fieldType
    }
    
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        guard let avatarStringURL = data["avatarStringURL"] as? String,
              let teamName = data["teamName"] as? String,
              let location = data["location"] as? String,
              let teamType = data["teamType"] as? String,
              let id = data["id"] as? String,
              let country = data["country"] as? String,
              let totalMoney = data["totalMoney"] as? String,
              let gameСosts = data["gameСosts"] as? String,
              let fieldType = data["fieldType"] as? String,
              let maxCountPlayersInTeam = data["maxCountPlayersInTeam"] as? Int,
              let currentCountPlayersInTeam = data["currentCountPlayersInTeam"] as? Int,
              let isHidden = data["isHidden"] as? Bool,
              let rating = data["rating"] as? Int else { return nil }
        self.avatarStringURL = avatarStringURL
        self.teamName = teamName
        self.location = location
        self.teamType = teamType
        self.rating = rating
        self.maxCountPlayersInTeam = maxCountPlayersInTeam
        self.isHidden = isHidden
        self.currentCountPlayersInTeam = currentCountPlayersInTeam
        self.id = id
        self.country = country
        self.totalMoney = totalMoney
        self.gameСosts = gameСosts
        self.fieldType = fieldType
    }
    
    var representation: [String: Any] {
        var rep: [String: Any]
        rep = ["avatarStringURL": avatarStringURL]
        rep["teamName"] = teamName
        rep["location"] = location
        rep["teamType"] = teamType
        rep["rating"] = rating
        rep["maxCountPlayersInTeam"] = maxCountPlayersInTeam
        rep["currentCountPlayersInTeam"] = currentCountPlayersInTeam
        rep["isHidden"] = isHidden
        rep["id"] = id
        rep["country"] = country
        rep["totalMoney"] = totalMoney
        rep["gameСosts"] = gameСosts
        rep["fieldType"] = fieldType
        return rep
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Team, rhs: Team) -> Bool {
        return lhs.id == rhs.id
    }
    
    func contains(filter: String?) -> Bool {
        guard let filter = filter else { return true }
        if filter.isEmpty { return true }
        let lowercasedFilter = filter.lowercased()
        return teamName.lowercased().contains(lowercasedFilter)
    }
}

