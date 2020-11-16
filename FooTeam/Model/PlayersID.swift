//
//  PlayersID.swift
//  FooTeam
//
//  Created by Виталий Сосин on 10.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import UIKit
import Firebase

struct PlayersID: Hashable, Decodable {
    let id: String
    
    init?(document: DocumentSnapshot) {
        guard let data = document.data() else { return nil}
        guard let id = data["uid"] as? String else { return nil }
        self.id = id
    }
    
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        guard let id = data["uid"] as? String else { return nil }
        self.id = id
    }
    
    var representation: [String: Any] {
        var rep: [String: Any]
        rep = ["uid": id]
        return rep
    }
}
