//
//  BufferIDplayer.swift
//  FooTeam
//
//  Created by Виталий Сосин on 21.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth

class BufferIDplayer {
    
    static let shared = BufferIDplayer()
    
    var playerID: String!
    
    func saveUserID(id: String) {
        playerID = id
    }
}


