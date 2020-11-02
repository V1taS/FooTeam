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
    
    init(
        avatarStringURL: String,
         teamName: String,
        location: String,
        teamType: String,
        rating: Int,
        maxCountPlayersInTeam: Int,
        isHidden: Bool,
        currentCountPlayersInTeam: Int) {
        self.avatarStringURL = avatarStringURL
        self.teamName = teamName
        self.location = location
        self.teamType = teamType
        self.id = UUID().uuidString
        self.rating = rating
        self.maxCountPlayersInTeam = maxCountPlayersInTeam
        self.isHidden = isHidden
        self.currentCountPlayersInTeam = currentCountPlayersInTeam
    }
    
    init?(document: DocumentSnapshot) {
        guard let data = document.data() else { return nil}
        guard let avatarStringURL = data["avatarStringURL"] as? String,
            let teamName = data["teamName"] as? String,
            let location = data["location"] as? String,
            let teamType = data["teamType"] as? String,
            let id = data["id"] as? String,
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
    }
    
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        
        guard let avatarStringURL = data["avatarStringURL"] as? String,
            let teamName = data["teamName"] as? String,
            let location = data["location"] as? String,
            let teamType = data["teamType"] as? String,
            let id = data["id"] as? String,
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

