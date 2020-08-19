//
//  Teams.swift
//  FooTeam
//
//  Created by Виталий Сосин on 10.08.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import UIKit
import FirebaseFirestore

struct Teams: Hashable, Decodable {
    
    var avatarStringURL: String = ""
    let teamName: String
    let location: String
    let teamType: String
    let id: String
    var rating: Int = 0
    let date: Date
    
    init(avatarStringURL: String, teamName: String, location: String, teamType: String, rating: Int) {
        self.avatarStringURL = avatarStringURL
        self.teamName = teamName
        self.location = location
        self.teamType = teamType
        self.id = UUID().uuidString
        self.rating = rating
        self.date = Date()
    }
    
    init?(document: DocumentSnapshot) {
        guard let data = document.data() else { return nil}
        guard let avatarStringURL = data["avatarStringURL"] as? String,
            let teamName = data["teamName"] as? String,
            let location = data["location"] as? String,
            let teamType = data["teamType"] as? String,
            let date = data["date"] as? Date,
            let id = data["id"] as? String,
            let rating = data["rating"] as? Int else { return nil }
        
        self.avatarStringURL = avatarStringURL
        self.teamName = teamName
        self.location = location
        self.teamType = teamType
        self.rating = rating
        self.date = date
        self.id = id
    }
    
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        
        guard let avatarStringURL = data["avatarStringURL"] as? String,
            let teamName = data["teamName"] as? String,
            let location = data["location"] as? String,
            let teamType = data["teamType"] as? String,
            let date = data["date"] as? Date,
            let id = data["id"] as? String,
            let rating = data["rating"] as? Int else { return nil }
        
        self.avatarStringURL = avatarStringURL
        self.teamName = teamName
        self.location = location
        self.teamType = teamType
        self.rating = rating
        self.date = date
        self.id = id
    }
    
    var representation: [String: Any] {
        var rep: [String: Any]
        rep = ["avatarStringURL": avatarStringURL]
        rep["teamName"] = teamName
        rep["location"] = location
        rep["teamType"] = teamType
        rep["rating"] = rating
        rep["date"] = date
        rep["id"] = id
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

