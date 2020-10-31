//
//  TeamTime.swift
//  FooTeam
//
//  Created by Виталий Сосин on 19.10.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import Foundation
import Firebase

struct TeamTime: Hashable, Decodable {
    var date: Date
    var dayOfWeek: String
    var game: String
    
    init(date: Date, dayOfWeek: String, game: String) {
        self.date = date
        self.dayOfWeek = dayOfWeek
        self.game = game
    }
    
    init?(document: DocumentSnapshot) {
        guard let data = document.data() else { return nil}
        guard let date = data["date"] as? Date,
              let dayOfWeek = data["dayOfWeek"] as? String,
              let game = data["game"] as? String else { return nil }
        self.date = date
        self.dayOfWeek = dayOfWeek
        self.game = game
    }
    
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        guard let stamp = data["date"] as? Timestamp,
              let dayOfWeek = data["dayOfWeek"] as? String,
              let game = data["game"] as? String else { return nil }
        self.date = stamp.dateValue()
        self.dayOfWeek = dayOfWeek
        self.game = game
    }
    
    var representation: [String: Any] {
        var rep: [String: Any]
        rep = ["date": date]
        rep["dayOfWeek"] = dayOfWeek
        rep["game"] = game
        return rep
    }
}
