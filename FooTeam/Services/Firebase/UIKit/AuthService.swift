//
//  AuthService.swift
//  FooTeam
//
//  Created by Виталий Сосин on 16.07.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn

class AuthService {
    
    static let shared = AuthService()
    private let auth = Auth.auth()
    
    // MARK: - login
    func login(email: String?, password: String?, completion: @escaping (Result<User, Error>) -> Void) {
        
        guard let email = email, let password = password else {
            completion(.failure(AuthError.notFilled))
            return
        }
        
        auth.signIn(withEmail: email, password: password) { (result, error) in
            guard let result = result else {
                completion(.failure(error!))
                return
            }
            completion(.success(result.user))
        }
    }
    
    // MARK: - google Login
    func googleLogin(user: GIDGoogleUser!, error: Error!, completion: @escaping (Result<User, Error>) -> Void) {
        if let error = error {
            completion(.failure(error))
            return
        }
        guard let auth = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: auth.idToken, accessToken: auth.accessToken)
        
        Auth.auth().signIn(with: credential) { (result, error) in
            guard let result = result else {
                completion(.failure(error!))
                return
            }
            completion(.success(result.user))
        }
    }
    
    // MARK: - register
    func register(email: String?, password: String?, confirmPassword: String?, completion: @escaping (Result<User, Error>) -> Void) {
        
        guard Validators.isFilled(email: email, password: password, confirmPassword: confirmPassword) else {
            completion(.failure(AuthError.notFilled))
            return
        }
        
        guard password!.lowercased() == confirmPassword!.lowercased() else {
            completion(.failure(AuthError.passwordsNotMatched))
            return
        }
        
        guard Validators.isSimpleEmail(email!) else {
            completion(.failure(AuthError.invalidEmail))
            return
        }
        
        auth.createUser(withEmail: email!, password: password!) { (result, error) in
            guard let result = result else {
                completion(.failure(error!))
                return
            }
            completion(.success(result.user))
        }
    }
    
    // MARK: - updating User Email
    func updatingUserEmail(getEmailAddres email: String) {
        auth.currentUser?.updateEmail(to: email, completion: { (error) in
            if let error = error as NSError? {
                switch AuthErrorCode(rawValue: error.code) {
                case .invalidRecipientEmail:
                    print("Error: Indicates an invalid recipient email was sent in the request.")
                case .invalidSender:
                    print("Indicates an invalid sender email is set in the console for this action.")
                case .invalidMessagePayload:
                    print("Indicates an invalid email template for sending update email.")
                case .emailAlreadyInUse:
                    print("The email address is already in use by another account.")
                case .invalidEmail:
                    print("The email address is badly formatted.")
                case .requiresRecentLogin:
                    print("Updating a user’s password is a security sensitive operation that requires a recent login from the user. This error indicates the user has not signed in recently enough. To resolve, reauthenticate the user by invoking reauthenticateWithCredential:completion: on FIRUser.")
                default:
                    print("Error message")
                }
            } else {
                print("Update email is successful")
            }
        })
    }
    
    // MARK: - Updating the User’s Password *** доработать ***
    func updatingUserPassword(getPassword password: String) {
        auth.currentUser?.updatePassword(to: password, completion: { (error) in
            if let error = error as NSError? {
                switch AuthErrorCode(rawValue: error.code) {
                case .userDisabled:
                    print("Error: The user account has been disabled by an administrator.")
                case .weakPassword:
                    print("Error: The password must be 6 characters long or more.")
                case .operationNotAllowed:
                    print("Error: The given sign-in provider is disabled for this Firebase project. Enable it in the Firebase console, under the sign-in method tab of the Auth section.")
                case .requiresRecentLogin:
                    print("Error: Updating a user’s password is a security sensitive operation that requires a recent login from the user. This error indicates the user has not signed in recently enough. To resolve, reauthenticate the user by invoking reauthenticateWithCredential:completion: on FIRUser.")
                default:
                    print("Error message: \(error.localizedDescription)")
                }
            } else {
                
                print("User signs up successfully")
            }
        })
    }
    
}
