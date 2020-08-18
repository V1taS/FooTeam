//
//  Teams.swift
//  iChat
//
//  Created by Виталий Сосин on 10.08.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import UIKit
import FirebaseFirestore

struct Teams: Hashable, Decodable {
    
    var avatarStringURL: String = ""
    var teamName: String
    var location: String
    var teamType: String
    var id: String
    var rating: Int = 0
    var date: Date
    
    init(avatarStringURL: String, teamName: String, location: String, teamType: String, id: String, rating: Int) {
        self.avatarStringURL = avatarStringURL
        self.teamName = teamName
        self.location = location
        self.teamType = teamType
        self.id = id
        self.rating = rating
        self.date = Date()
    }
    
    init?(document: DocumentSnapshot) {
        guard let data = document.data() else { return nil}
        guard let avatarStringURL = data["avatarStringURL"] as? String,
            let teamName = data["teamName"] as? String,
            let location = data["location"] as? String,
            let teamType = data["teamType"] as? String,
            let id = data["id"] as? String,
            let date = data["date"] as? Date,
            let rating = data["rating"] as? Int else { return nil }
        
        self.avatarStringURL = avatarStringURL
        self.teamName = teamName
        self.location = location
        self.teamType = teamType
        self.id = id
        self.rating = rating
        self.date = date
    }
    
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        
        guard let avatarStringURL = data["avatarStringURL"] as? String,
            let teamName = data["teamName"] as? String,
            let location = data["location"] as? String,
            let teamType = data["teamType"] as? String,
            let id = data["id"] as? String,
            let date = data["date"] as? Date,
            let rating = data["rating"] as? Int else { return nil }
        
        self.avatarStringURL = avatarStringURL
        self.teamName = teamName
        self.location = location
        self.teamType = teamType
        self.id = id
        self.rating = rating
        self.date = date
    }
    
    var representation: [String: Any] {
        var rep: [String: Any]
        rep = ["avatarStringURL": avatarStringURL]
        rep["teamName"] = teamName
        rep["location"] = location
        rep["teamType"] = teamType
        rep["id"] = id
        rep["rating"] = rating
        rep["date"] = date
        return rep
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Teams, rhs: Teams) -> Bool {
        return lhs.id == rhs.id
    }
    
    func contains(filter: String?) -> Bool {
        guard let filter = filter else { return true }
        if filter.isEmpty { return true }
        let lowercasedFilter = filter.lowercased()
        return teamName.lowercased().contains(lowercasedFilter)
    }
}

