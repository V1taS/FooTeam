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
    
    init(date: Date, dayOfWeek: String) {
        self.date = date
        self.dayOfWeek = dayOfWeek
    }
    
    init?(document: DocumentSnapshot) {
        guard let data = document.data() else { return nil}
        guard let date = data["date"] as? Date,
              let dayOfWeek = data["dayOfWeek"] as? String else { return nil }
        self.date = date
        self.dayOfWeek = dayOfWeek
    }
    
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        guard let stamp = data["date"] as? Timestamp,
              let dayOfWeek = data["dayOfWeek"] as? String else { return nil }
        self.date = stamp.dateValue()
        self.dayOfWeek = dayOfWeek
    }
    
    var representation: [String: Any] {
        var rep: [String: Any]
        rep = ["date": date]
        rep["dayOfWeek"] = dayOfWeek
        return rep
    }
}
