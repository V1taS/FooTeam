//
//  CollectionReferenceForFirebase.swift
//  FooTeam
//
//  Created by Виталий Сосин on 17.11.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import Firebase
import SwiftUI

class CollectionReferenceForFirebase {
    static let shared = CollectionReferenceForFirebase()
    private let db = Firestore.firestore()
    
    // MARK: Создаем ссылку для Firebase чтобы удалить даты, после удаления команды
    func converteference(idTeam: String) -> CollectionReference {
        return db.collection(["teams", idTeam, "dateAndTimeOfTheGame"].joined(separator: "/"))
    }
}
