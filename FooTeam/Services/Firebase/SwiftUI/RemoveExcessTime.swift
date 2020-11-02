//
//  RemoveExcessTime.swift
//  FooTeam
//
//  Created by Виталий Сосин on 01.11.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import Foundation
import Firebase

class RemoveExcessTime {
    
    static let shared = RemoveExcessTime()
    
    private let db = Firestore.firestore()
    
    // MARK: - f
    func removeTime(gameInWeak: Int, ref: CollectionReference) {
        switch gameInWeak {
        case 0:
            for i in 2...7 {
                ref.whereField("game", isEqualTo: "игра-\(i)").getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        for document in querySnapshot!.documents {
                            document.reference.delete()
                        }
                    }
                }
            }
        case 1:
            for i in 3...7 {
                ref.whereField("game", isEqualTo: "игра-\(i)").getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        for document in querySnapshot!.documents {
                            document.reference.delete()
                        }
                    }
                }
            }
        case 2:
            for i in 4...7 {
                ref.whereField("game", isEqualTo: "игра-\(i)").getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        for document in querySnapshot!.documents {
                            document.reference.delete()
                        }
                    }
                }
            }
        case 3:
            for i in 5...7 {
                ref.whereField("game", isEqualTo: "игра-\(i)").getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        for document in querySnapshot!.documents {
                            document.reference.delete()
                        }
                    }
                }
            }
        case 4:
            for i in 6...7 {
                ref.whereField("game", isEqualTo: "игра-\(i)").getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        for document in querySnapshot!.documents {
                            document.reference.delete()
                        }
                    }
                }
            }
        case 5:
            for i in 7...7 {
                ref.whereField("game", isEqualTo: "игра-\(i)").getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        for document in querySnapshot!.documents {
                            document.reference.delete()
                        }
                    }
                }
            }
        default:
            print("")
        }
    }
}
