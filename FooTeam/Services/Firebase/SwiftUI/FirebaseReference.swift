//
//  FirebaseReference.swift
//  FooTeam
//
//  Created by Виталий Сосин on 04.09.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI
import Firebase

enum FCollectionReferenc: String {
    case players = "players"
    case teams = "teams"
}

func FirebaseReference(_ collectionReference: FCollectionReferenc) -> CollectionReference {
    return Firestore.firestore().collection(collectionReference.rawValue)
}
