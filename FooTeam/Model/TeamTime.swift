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
    
    init(date: Date) {
        self.date = date
    }
    
    init?(document: DocumentSnapshot) {
        guard let data = document.data() else { return nil}
        guard let date = data["date"] as? Date else { return nil }
        self.date = date
    }
    
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        guard let date = data["date"] as? Date else { return nil }
        self.date = date
    }
    
    var representation: [String: Any] {
        var rep: [String: Any]
        rep = ["date": date]
        return rep
    }
}
