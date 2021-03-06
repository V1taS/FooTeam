//
//  SignUpViewController.swift
//  FooTeam
//
//  Created by Виталий Сосин on 13.07.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    let welcomeLabel = UILabel(
        text: NSLocalizedString("SignUpViewControllerWelcomeLabel",
                                comment: "Sign in"),
        font: .bolt20(),
        textAlignment: .center
    )
    let descriptionFTLabel = UILabel(
        text: NSLocalizedString("SignUpViewControllerDescriptionFTLabel",
                                comment: "descriptionFTLabel"),
        font: .avenir14(),
        color: .systemGray,
        textAlignment: .center
    )
    let emailLabel = UILabel(
        text: NSLocalizedString("SignUpViewControllerEmailLabell",
                                comment: "Email"),
        font: .markerFel14()
    )
    let passwordLabel = UILabel(
        text: NSLocalizedString("SignUpViewControllerPasswordLabel",
                                comment: "Password"),
        font: .markerFel14()
    )
    let confirmPasswodLabel = UILabel(
        text: NSLocalizedString("SignUpViewControllerConfirmPasswodLabel",
                                comment: "Confirm the password"),
        font: .markerFel14()
    )
    let alreadyOnboardLabel = UILabel(
        text: NSLocalizedString("SignUpViewControllerAlreadyOnboardLabel",
                                comment: "Already Registered?"),
        font: .avenir14()
    )
    
    let emailTextField = CustomeTextField(placeholder: "  demo@mail.ru")
    let passwordTextField = CustomeTextField(placeholder: "  Demo12", isSecure: true)
    let confirmPasswordTextField = CustomeTextField(placeholder: "  Demo12", isSecure: true)
    
    let signUpButton = UIButton(
        title: NSLocalizedString("SignUpViewControllerSignUpButton",
                                 comment: "Register now"),
        titleColor: .white,
        backgroundColor: .buttonDark(),
        font: .bolt14(),
        borderColor: .textFieldLight()
    )
    
    let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(
            NSLocalizedString("SignUpViewControllerClose",
                              comment: "close"),
            for: .normal)
        
        button.setTitleColor(.blackAndWhite(), for: .normal)
        button.titleLabel?.font = .bolt14()
        return button
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(
            NSLocalizedString("SignUpViewControllerlogin",
                              comment: "login"),
            for: .normal
        )
        button.setTitleColor(.buttonRed(), for: .normal)
        button.titleLabel?.font = .bolt14()
        return button
    }()
    
    weak var delegate: AuthNavigatingDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addKeyboardObserver()
        
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        self.confirmPasswordTextField.delegate = self
        
        view.backgroundColor = .whiteAndBlack()
        setupConstraints()
        
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
    }
}

// MARK: - Actions
extension SignUpViewController {
    @objc private func signUpButtonTapped() {
        AuthService.shared.register(
            email: emailTextField.text,
            password: passwordTextField.text,
            confirmPassword: confirmPasswordTextField.text) { (result) in
            switch result {
            case .success(let user):
                self.showAlert(
                    with: NSLocalizedString("SignUpViewControllerSuccessfully",
                                            comment: "Successfully"),
                    and: NSLocalizedString("SignUpViewControllerYouAreLogged",
                                           comment: "You are logged in")
                ) {
                    let setupVC = SetupProfileViewController(currentUser: user)
                    setupVC.modalPresentationStyle = .fullScreen
                    self.present(setupVC, animated: true, completion: nil)
                }
                
            case .failure(let error):
                self.showAlert(
                    with: NSLocalizedString("SignUpViewControllerError",
                                            comment: "Error"),
                    and: error.localizedDescription
                )
            }
        }
    }
    
    @objc private func loginButtonTapped() {
        self.dismiss(animated: true) {
            self.delegate?.toLoginVC()
        }
    }
    
    @objc private func closeButtonTapped() {
        self.dismiss(animated: true)
    }
}

// MARK: - Setup constraints
extension SignUpViewController {
    private func setupConstraints() {
        
        let topStackView = UIStackView(
            arrangedSubviews: [welcomeLabel, descriptionFTLabel],
            axis: .vertical,
            spacing: 20
        )
        
        let emailStackView = UIStackView(
            arrangedSubviews: [emailLabel, emailTextField],
            axis: .vertical,
            spacing: 5
        )
        
        let passwordStackView = UIStackView(
            arrangedSubviews: [passwordLabel, passwordTextField],
            axis: .vertical,
            spacing: 5
        )
        
        let confirmPasswordStackView = UIStackView(
            arrangedSubviews: [confirmPasswodLabel, confirmPasswordTextField],
            axis: .vertical,
            spacing: 5
        )
        confirmPasswordTextField.backgroundColor = .systemGray6
        confirmPasswordTextField.layer.cornerRadius = 5
        
        let stackView = UIStackView(
            arrangedSubviews: [emailStackView,
                               passwordStackView,
                               confirmPasswordStackView,
                               signUpButton],
            axis: .vertical,
            spacing: 20)
        
        signUpButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        
        loginButton.contentHorizontalAlignment = .leading
        
        let bottomStackView = UIStackView(
            arrangedSubviews: [alreadyOnboardLabel, loginButton],
            axis: .horizontal,
            spacing: 10
        )
        bottomStackView.alignment = .firstBaseline
        
        let footerStackView = UIView()
        footerStackView.backgroundColor = .systemGray6
        
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        topStackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        footerStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(closeButton)
        view.addSubview(topStackView)
        view.addSubview(stackView)
        view.addSubview(footerStackView)
        view.addSubview(bottomStackView)
        
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 52),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32)
        ])
        
        NSLayoutConstraint.activate([
            topStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 160),
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
        alreadyOnboardLabel.leadingAnchor.constraint(
            equalTo: bottomStackView.leadingAnchor,
            constant: 40
        ).isActive = true
        
        NSLayoutConstraint.activate([
            footerStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            footerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            footerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            footerStackView.heightAnchor.constraint(equalToConstant: 95)
        ])
    }
}

// MARK: - Show Alert
extension UIViewController {
    func showAlert(
        with title: String,
        and message: String,
        completion: @escaping () -> Void = { }
    ) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
            completion()
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}


// MARK: - Text Field Delegate
extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            confirmPasswordTextField.becomeFirstResponder()
        } else if textField == confirmPasswordTextField {
            confirmPasswordTextField.resignFirstResponder()
        }
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
}
