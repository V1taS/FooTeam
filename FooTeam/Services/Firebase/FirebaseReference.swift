//
//  FirebaseReference.swift
//  FooTeam
//
//  Created by Виталий Сосин on 04.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import Foundation
import FirebaseFirestore

enum FCollectionReferenc: String {
    case Player
    case Players = "players"
    case Team
    case Teams = "teams"
}

func FirebaseReference(_ collectionReference: FCollectionReferenc) -> CollectionReference {
    return Firestore.firestore().collection(collectionReference.rawValue)
}
