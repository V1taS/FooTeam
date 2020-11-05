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
    
    private let db = Firestore.firestore()
    
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
    
    private var currentUserId: String {
        return Auth.auth().currentUser!.uid
    }
    
    var currentUser: Player!
    
    // MARK: - Get User Data
    func getUserData(user: User, completion: @escaping (Result<Player, Error>) -> Void) {
        let docRef = usersRef.document(user.uid)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                guard let player = Player(document: document) else {
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
    
    // MARK: - Get User Data Simple
    func getUserDataSimple() {
        let docRef = usersRef.document(currentUserId)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                guard let player = Player(document: document) else { return }
                self.currentUser = player
                print("Пользователь получен в getUserDataSimple")
            }
        }
    }
    
    
    // MARK: - Save Profile
    func saveProfileWith(id: String, email: String, name: String, avatarImage: UIImage?, whoAreYou: String, positionPlayer: String, completion: @escaping (Result<Player, Error>) -> Void) {
        
        guard Validators.isFilled(username: name, whoAreYou: whoAreYou) else {
            completion(.failure(UserError.notFilled))
            return
        }
        
        var player = Player(name: name,
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
                            numberOfGoals: 0,
                            winGame: 0,
                            losGame: 0,
                            captain: false)
        
        StorageService.shared.uploadAvaPlayer(photo: avatarImage!, idPlayer: currentUserId) { (result) in
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
                      player: Player,
                      completion: @escaping (Result<Team, Error>) -> Void) {
        
        guard Validators.isFilled(teamName: teamName, location: location) else {
            completion(.failure(UserError.notFilled))
            return
        }
        
        var player = player
        var team = Team(
            avatarStringURL: "not exist",
            teamName: teamName!,
            location: location!,
            teamType: teamType!,
            rating: rating!,
            maxCountPlayersInTeam: 18,
            isHidden: false,
            currentCountPlayersInTeam: 1,
            country: "",
            totalMoney: "",
            gameСosts: "",
            fieldType: "Мини"
        )
        let refCountPlayers = db.collection(["teams", team.id, "actionsPlayers"].joined(separator: "/"))
        
        StorageService.shared.uploadAvaTeam(photo: avatarTeam!, idTeam: team.id) { (result) in
            switch result {
            
            case .success(let url):
                team.avatarStringURL = url.absoluteString
                
                
                player.captain = true
                player.idTeam = team.id
                
                self.usersRef.document(player.id).setData(player.representation) { (error) in
                    if let error = error {
                        completion(.failure(error))
                    }
                }
                
                refCountPlayers.document(player.id).setData(player.representationPlayer) { (error) in
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
