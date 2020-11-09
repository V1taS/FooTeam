//
//  AuthViewController.swift
//  FooTeam
//
//  Created by Виталий Сосин on 28.03.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import UIKit
import GoogleSignIn
import FirebaseAuth
import AuthenticationServices

class AuthViewController: UIViewController {
    
    var logoImageView = UIImageView(image: #imageLiteral(resourceName: "logo"), contentMode: .scaleAspectFill)
    
    let registerInFTLabel = UILabel(text: NSLocalizedString("AuthViewControllerRegisterInFTLabel" ,comment:"Register with FooTeam"), font: .bolt20(), textAlignment: .center)
    let descriptionFTLabel = UILabel(text: NSLocalizedString("AuthViewControllerDescriptionFTLabel" ,comment:"DescriptionFTLabel"), font: .avenir14(), color: .systemGray, textAlignment: .center)
    let alreadyOnboardLabel = UILabel(text: NSLocalizedString("AuthViewControllerAlreadyOnboardLabel" ,comment:"Already have an account?"), font: .avenir14())
    
    let appleButton = UIButton(title: NSLocalizedString("AuthViewControllerAppleButton" ,comment:"Continue with Apple?"),
                               titleColor: .whiteAndBlack(),
                               backgroundColor: .blackAndWhite(),
                               font: .bolt14(),
                               logo: #imageLiteral(resourceName: "appleIcon"))
    let googleButton = UIButton(title: NSLocalizedString("AuthViewControllerGoogleButton" ,comment:"Continue on Google?"),
                                titleColor: .buttonDark(),
                                backgroundColor: .mainWhite(),
                                font: .bolt14(),
                                logo: #imageLiteral(resourceName: "googleLogo"))
    let emailButton = UIButton(title: NSLocalizedString("AuthViewControllerEmailButton" ,comment:"Enter email"),
                               titleColor: .buttonDark(),
                               backgroundColor: .mainWhite(),
                               font: .bolt14(),
                               logo: #imageLiteral(resourceName: "messagingIcon"))
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(NSLocalizedString("AuthViewControllerlogin" ,comment:"login"), for: .normal)
        button.setTitleColor(.buttonRed(), for: .normal)
        button.titleLabel?.font = .bolt14()
        return button
    }()
    
    let signUpVC = SignUpViewController()
    let loginVC = LoginViewController()
    
    fileprivate var currentNonce: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .whiteAndBlack()
        setupConstraints()
        
        emailButton.addTarget(self, action: #selector(emailButtonTapped), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        appleButton.addTarget(self, action: #selector(appleButtonTapped), for: .touchUpInside)
        googleButton.addTarget(self, action: #selector(googleButtonTapped), for: .touchUpInside)
        
        signUpVC.delegate = self
        loginVC.delegate = self
        
        GIDSignIn.sharedInstance()?.delegate = self
    }
}

// MARK: - Actions
extension AuthViewController {
    @objc private func emailButtonTapped() {
        signUpVC.modalPresentationStyle = .fullScreen
        present(signUpVC, animated: true, completion: nil)
    }
    
    @objc private func loginButtonTapped() {
        loginVC.modalPresentationStyle = .fullScreen
        present(loginVC, animated: true, completion: nil)
    }
    
    @objc private func appleButtonTapped() {
        let nonce = randomNonceString()
        currentNonce = nonce
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }
    
    @objc private func googleButtonTapped() {
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().signIn()
    }
}

// MARK: - Setup constraints
extension AuthViewController {
    private func setupConstraints() {
        
        let topStackView = UIStackView(arrangedSubviews: [registerInFTLabel, descriptionFTLabel], axis: .vertical, spacing: 20)
        
        let stackView = UIStackView(arrangedSubviews: [emailButton, googleButton, appleButton], axis: .vertical, spacing: 10)
        
        loginButton.contentHorizontalAlignment = .fill
        let bottomStackView = UIStackView(arrangedSubviews: [alreadyOnboardLabel, loginButton],
                                          axis: .horizontal,
                                          spacing: 10)
        
        let footerStackView = UIView()
        footerStackView.backgroundColor = .systemGray6
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        topStackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        footerStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(logoImageView)
        view.addSubview(topStackView)
        view.addSubview(stackView)
        view.addSubview(footerStackView)
        view.addSubview(bottomStackView)
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 160),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 200),
            logoImageView.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        NSLayoutConstraint.activate([
            topStackView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 20),
            topStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            topStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topStackView.bottomAnchor, constant: 40),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
        
        NSLayoutConstraint.activate([
            bottomStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            bottomStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        alreadyOnboardLabel.leadingAnchor.constraint(equalTo: bottomStackView.leadingAnchor, constant: 40).isActive = true
        
        NSLayoutConstraint.activate([
            footerStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            footerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            footerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            footerStackView.heightAnchor.constraint(equalToConstant: 95)
        ])
    }
}

// MARK: - AuthNavigatingDelegate
extension AuthViewController: AuthNavigatingDelegate {
    func toLoginVC() {
        loginVC.modalPresentationStyle = .fullScreen
        present(loginVC, animated: true, completion: nil)
    }
    
    func toSignUpVC() {
        signUpVC.modalPresentationStyle = .fullScreen
        present(signUpVC, animated: true, completion: nil)
    }
}

// MARK: - GIDSignInDelegate
extension AuthViewController: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        AuthService.shared.googleLogin(user: user, error: error) { (result) in
            switch result {
            case .success(let user):
                FirestoreService.shared.getUserData(user: user) { (result) in
                    switch result {
                    case .success(_):
                        UIApplication.getTopViewController()?.showAlert(with: NSLocalizedString("AuthViewControllerSuccessfully" ,comment:"Successfully"), and: NSLocalizedString("AuthViewControllerYouAreLogged" ,comment:"You are logged in")) {
                            let mainContentFooTeam = UIHostingController(rootView: TabViewFooTeam())
                            mainContentFooTeam.modalPresentationStyle = .fullScreen
                            UIApplication.getTopViewController()?.present(mainContentFooTeam, animated: true, completion: nil)
                        }
                    case .failure(_):
                        UIApplication.getTopViewController()?.showAlert(with: NSLocalizedString("AuthViewControllerSuccessfully" ,comment:"Successfully"), and: NSLocalizedString("AuthViewControllerYouAreRegistered" ,comment:"You are registered")) {
                            UIApplication.getTopViewController()?.present(SetupProfileViewController(currentUser: user), animated: true, completion: nil)
                        }
                    } // result
                }
            case .failure(let error):
                self.showAlert(with: NSLocalizedString("AuthViewControllerError" ,comment:"Error"), and: error.localizedDescription)
            }
        }
    }
}

// MARK: - Sign in with Apple
extension AuthViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let nonce = currentNonce else {
                fatalError("Invalid state: A login callback was received, but no login request was sent.")
            }
            
            guard let appleIDToken = appleIDCredential.identityToken else {
                print("Unable to fetch identity token")
                return
            }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                return
            }
            // Initialize a Firebase credential.
            let credential = OAuthProvider.credential(withProviderID: "apple.com",
                                                      idToken: idTokenString,
                                                      rawNonce: nonce)
            
            // Sign in with Firebase.
            Auth.auth().signIn(with: credential) { (authResult, error) in
                if (error != nil) {
                    print(error!.localizedDescription)
                    return
                }
                // User is signed in to Firebase with Apple.
                // ...
                switch authResult {
                case .none:
                    let auth = AuthViewController()
                    auth.modalPresentationStyle = .fullScreen
                    self.present(auth, animated: true, completion: nil)
                case .some(let user):
                    FirestoreService.shared.getUserData(user: user.user) { (result) in
                        switch result {
                        case .success(let player):
                            if player.idTeam.isEmpty {
                                UIApplication.getTopViewController()?.showAlert(with: NSLocalizedString("AuthViewControllerSuccessfully" ,comment:"Successfully"), and: NSLocalizedString("AuthViewControllerYouAreLogged" ,comment:"You are logged in")) {
                                    let mainContentFooTeam = UIHostingController(rootView: JoinToTeamView())
                                    mainContentFooTeam.modalPresentationStyle = .fullScreen
                                    UIApplication.getTopViewController()?.present(mainContentFooTeam, animated: true, completion: nil)
                                }
                            } else {
                                UIApplication.getTopViewController()?.showAlert(with: NSLocalizedString("AuthViewControllerSuccessfully" ,comment:"Successfully"), and: NSLocalizedString("AuthViewControllerYouAreLogged" ,comment:"You are logged in")) {
                                    let mainContentFooTeam = UIHostingController(rootView: TabViewFooTeam())
                                    mainContentFooTeam.modalPresentationStyle = .fullScreen
                                    UIApplication.getTopViewController()?.present(mainContentFooTeam, animated: true, completion: nil)
                                }
                            }
                        case .failure(_):
                            UIApplication.getTopViewController()?.showAlert(with: NSLocalizedString("AuthViewControllerSuccessfully" ,comment:"Successfully"), and: NSLocalizedString("AuthViewControllerYouAreRegistered" ,comment:"You are registered")) {
                                UIApplication.getTopViewController()?.present(SetupProfileViewController(currentUser: user.user), animated: true, completion: nil)
                            }
                            
                        } // result
                    }
                }
                
            }
            
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Somthing bad happend", error)
    }
}

extension AuthViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
    }
}

// Adapted from https://auth0.com/docs/api-auth/tutorials/nonce#generate-a-cryptographically-random-nonce
private func randomNonceString(length: Int = 32) -> String {
    precondition(length > 0)
    let charset: Array<Character> =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
    var result = ""
    var remainingLength = length
    
    while remainingLength > 0 {
        let randoms: [UInt8] = (0 ..< 16).map { _ in
            var random: UInt8 = 0
            let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
            if errorCode != errSecSuccess {
                fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
            }
            return random
        }
        
        randoms.forEach { random in
            if remainingLength == 0 {
                return
            }
            
            if random < charset.count {
                result.append(charset[Int(random)])
                remainingLength -= 1
            }
        }
    }
    
    return result
}

// MARK: - SwiftUI
import SwiftUI

struct AuthVCProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        let viewController = AuthViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<AuthVCProvider.ContainerView>) -> AuthViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: AuthVCProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<AuthVCProvider.ContainerView>) {
            
        }
    }
}

