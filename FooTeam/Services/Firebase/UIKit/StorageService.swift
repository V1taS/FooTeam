//
//  StorageService.swift
//  FooTeam
//
//  Created by Виталий Сосин on 17.07.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage

class StorageService {
    
    static let shared = StorageService()

    let storageRef = Storage.storage().reference()
    
    private var avaPlayersRef: StorageReference {
        return storageRef.child("avaPlayers")
    }
    
    private var avaTeamsRef: StorageReference {
        return storageRef.child("avaTeams")
    }
    
    // MARK: - upload Image Player
    func uploadAvaPlayer(photo: UIImage, idPlayer: String, completion: @escaping (Result<URL, Error>) -> Void) {
        
        let photo = photo.resizeWith(percentage: 0.3)
        guard let imageData = photo?.pngData() else { return }
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/png"
        
        avaPlayersRef.child(idPlayer).putData(imageData, metadata: metadata) { (metadata, error) in
            guard let _ = metadata else {
                completion(.failure(error!))
                return
            }
            self.avaPlayersRef.child(idPlayer).downloadURL { (url, error) in
                guard let downloadURL = url else {
                    completion(.failure(error!))
                    return
                }
                completion(.success(downloadURL))
            }
        }
    }
    
    // MARK: - upload Image Team
    func uploadAvaTeam(photo: UIImage, idTeam: String, completion: @escaping (Result<URL, Error>) -> Void) {

        let photo = photo.resizeWith(percentage: 0.3)
        guard let imageData = photo?.pngData() else { return }
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/png"
        
        avaTeamsRef.child(idTeam).putData(imageData, metadata: metadata) { (metadata, error) in
            guard let _ = metadata else {
                completion(.failure(error!))
                return
            }
            self.avaTeamsRef.child(idTeam).downloadURL { (url, error) in
                guard let downloadURL = url else {
                    completion(.failure(error!))
                    return
                }
                completion(.success(downloadURL))
            }
        }
    }
    
    // MARK: - download Image
    func downloadImage(url: URL, completion: @escaping (Result<UIImage?, Error>) -> Void) {
        let ref = Storage.storage().reference(forURL: url.absoluteString)
        let megaByte = Int64(1 * 1024 * 1024)
        ref.getData(maxSize: megaByte) { (data, error) in
            guard let imageData = data else {
              completion(.failure(error!))
              return
            }
            completion(.success(UIImage(data: imageData)))
        }
    }
}
