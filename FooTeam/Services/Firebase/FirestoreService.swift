//
//  FirestoreService.swift
//  FooTeam
//
//  Created by Виталий Сосин on 17.07.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import Firebase
import FirebaseAuth

class FirestoreService {
    
    static let shared = FirestoreService()
    
    let db = Firestore.firestore()
    
    private var usersRef: CollectionReference {
        return db.collection("players")
    }
    
    private var teamsRef: CollectionReference {
        return db.collection("teams")
    }
    
    private var waitingChatsRef: CollectionReference {
        return db.collection(["players", currentUser.id, "waitingChats"].joined(separator: "/"))
    }
    
    private var activeChatsRef: CollectionReference {
        return db.collection(["players", currentUser.id, "activeChats"].joined(separator: "/"))
    }
    
    var currentUser: Players!
    var listPlayers: [Players]!
    
    
    // MARK: - Get User Data
    func getlistPlayers() {
        var players = [Players]()
        
        let db = Firestore.firestore()
        db.collection("players").addSnapshotListener { (snap, err) in
            
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }
            
            for doc in (snap?.documentChanges)! {
                
                guard let name = doc.document.data()["name"] as? String,
                    let nameTeam = doc.document.data()["nameTeam"] as? String,
                    let email = doc.document.data()["email"] as? String,
                    let avatarStringURL = doc.document.data()["avatarStringURL"] as? String,
                    let whoAreYou = doc.document.data()["whoAreYou"] as? String,
                    let id = doc.document.data()["uid"] as? String,
                    let idTeam = doc.document.data()["idTeam"] as? String,
                    
                    let teamNumber = doc.document.data()["teamNumber"] as? Int,
                    let payment = doc.document.data()["payment"] as? String,
                    let iGo = doc.document.data()["iGo"] as? Bool,
                    let subscription = doc.document.data()["subscription"] as? Bool,
                    let rating = doc.document.data()["rating"] as? Int,
                    let position = doc.document.data()["position"] as? String,
                    let numberOfGames = doc.document.data()["numberOfGames"] as? Int,
                    let numberOfGoals = doc.document.data()["numberOfGoals"] as? Int,
                    let winGame = doc.document.data()["winGame"] as? Int,
                    let losGame = doc.document.data()["losGame"] as? Int,
                    let captain = doc.document.data()["captain"] as? Bool else { return }
                
                DispatchQueue.main.async {
                    players.append(Players(name: name,
                                           nameTeam: nameTeam,
                                           email: email,
                                           avatarStringURL: avatarStringURL,
                                           whoAreYou: whoAreYou,
                                           id: id,
                                           idTeam: idTeam,
                                           teamNumber: teamNumber,
                                           payment: payment,
                                           iGo: iGo,
                                           subscription: subscription,
                                           rating: rating,
                                           position: position,
                                           numberOfGames: numberOfGames,
                                           numberOfGoals: numberOfGoals,
                                           winGame: winGame,
                                           losGame: losGame,
                                           captain: captain))
                    
                    self.listPlayers = players
                }
            }
        }
    }
    
    
    // MARK: - Get User Data
    func getUserData(user: User, completion: @escaping (Result<Players, Error>) -> Void) {
        let docRef = usersRef.document(user.uid)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                guard let player = Players(document: document) else {
                    completion(.failure(UserError.cannotUnwrapToMUser))
                    return
                }
                self.currentUser = player
                completion(.success(player))
            } else {
                completion(.failure(UserError.cannotGetUserInfo))
            }
        }
    }
    
    
    // MARK: - Save Profile
    func saveProfileWith(id: String, email: String, name: String, avatarImage: UIImage?, whoAreYou: String, positionPlayer: String, completion: @escaping (Result<Players, Error>) -> Void) {
        
        guard Validators.isFilled(username: name, whoAreYou: whoAreYou) else {
            completion(.failure(UserError.notFilled))
            return
        }
        
        var player = Players(name: name,
                             nameTeam: "Нет команды",
                             email: email,
                             avatarStringURL: "",
                             whoAreYou: whoAreYou,
                             id: id,
                             idTeam: "",
                             teamNumber: 0,
                             payment: "0",
                             iGo: false,
                             subscription: false,
                             rating: 0,
                             position: positionPlayer,
                             numberOfGames: 0,
                             numberOfGoals: 0,
                             winGame: 0,
                             losGame: 0,
                             captain: false)
        
        StorageService.shared.uploadAvaPlayer(photo: avatarImage!) { (result) in
            switch result {
                
            case .success(let url):
                player.avatarStringURL = url.absoluteString
                self.usersRef.document(player.id).setData(player.representation) { (error) in
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.success(player))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        } // StorageService
    } // saveProfileWith
    
    
    // MARK: - Save Team
    func saveTeamWith(avatarTeam: UIImage?,
                      teamName: String?,
                      location: String?,
                      teamType: String?,
                      rating: Int?,
                      player: Players,
                      completion: @escaping (Result<Teams, Error>) -> Void) {
        
        guard Validators.isFilled(teamName: teamName, location: location) else {
            completion(.failure(UserError.notFilled))
            return
        }
        
        var player = player
        var team = Teams(avatarStringURL: "not exist", teamName: teamName!, location: location!, teamType: teamType!, rating: rating!)
        let refCountPlayers = db.collection(["teams", team.id, "players"].joined(separator: "/"))
        
        StorageService.shared.uploadAvaTeam(photo: avatarTeam!) { (result) in
            switch result {
                
            case .success(let url):
                team.avatarStringURL = url.absoluteString
                
                
                player.captain = true
                player.idTeam = team.id
                player.nameTeam = teamName!
                
                self.usersRef.document(player.id).setData(player.representation) { (error) in
                    if let error = error {
                        completion(.failure(error))
                    }
                }
                
                refCountPlayers.document(player.id).setData(player.refPlayerRepresentation) { (error) in
                    if let error = error {
                        completion(.failure(error))
                        return
                    }
                }
                self.teamsRef.document(team.id).setData(team.representation) { (error) in
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.success(team))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        } // StorageService
    } // saveTeamWith
}
