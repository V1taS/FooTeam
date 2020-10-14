//
//  LoginViewController.swift
//  FooTeam
//
//  Created by Виталий Сосин on 13.07.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FirebaseAuth

class LoginViewController: UIViewController {
    
    let welcomeLabel = UILabel(text: "Войдите в FooTeam", font: .bolt20(), textAlignment: .center)
    let descriptionFTLabel = UILabel(text: "Создавайте и управляйте своей командой, следите за статистикой и получай больше возможностей.", font: .avenir14(), color: .systemGray, textAlignment: .center)
    
    let emailLabel = UILabel(text: "Ввести эл. почту", font: .markerFel14())
    let passwordLabel = UILabel(text: "Ввести пароль", font: .markerFel14())
    let needAnAccountLabel = UILabel(text: "Нет учетной записи?", font: .avenir14())
    
    let googleButton = UIButton(title: "Продолжить в Google", titleColor: .black, backgroundColor: .white, font: .bolt14(), logo: #imageLiteral(resourceName: "googleLogo"))
    let forgottenButton = UIButton(title: "Забыли пароль?", titleColor: .black, backgroundColor: .white, font: .bolt14())
    let emailTextField = CustomeTextField(placeholder: "  demo@mail.ru")
    let passwordTextField = CustomeTextField(placeholder: "  Demo12", isSecure: true)
    
    let loginButton = UIButton(title: "Войти", titleColor: .white, backgroundColor: .buttonDark(), font: .bolt14())
    let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("закрыть", for: .normal)
        button.setTitleColor(.buttonDark(), for: .normal)
        button.titleLabel?.font = .bolt14()
        return button
    }()
    
    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Зарегистрироваться", for: .normal)
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
        
        view.backgroundColor = .white
        setupConstraints()
        
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        googleButton.addTarget(self, action: #selector(googleButtonTapped), for: .touchUpInside)
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        forgottenButton.addTarget(self, action: #selector(forgottenButtonTapped), for: .touchUpInside)
    }
}

// MARK: - Actions
extension LoginViewController {
    
    @objc private func googleButtonTapped() {
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().signIn()
    }
    
    @objc private func loginButtonTapped() {
        AuthService.shared.login(
            email: emailTextField.text!,
            password: passwordTextField.text!) { (result) in
                switch result {
                case .success(let user):
                    self.showAlert(with: "Успешно!", and: "Вы авторизованы!") {
                        FirestoreService.shared.getUserData(user: user) { (result) in
                            switch result {
                            case .success( _):
                                let mainContentFooTeam = UIHostingController(rootView: TabViewFooTeam())
                                mainContentFooTeam.modalPresentationStyle = .fullScreen
                                self.present(mainContentFooTeam, animated: true, completion: nil)
                            case .failure(_):
                                self.present(SetupProfileViewController(currentUser: user), animated: true, completion: nil)
                            }
                        }
                    }
                case .failure(let error):
                    self.showAlert(with: "Ошибка!", and: error.localizedDescription)
                }
        }
    }
    
    @objc private func signUpButtonTapped() {
        dismiss(animated: true) {
            self.delegate?.toSignUpVC()
        }
    }
    
    @objc private func closeButtonTapped() {
        self.dismiss(animated: true)
    }
    
    @objc private func forgottenButtonTapped() {
        showAlertForgottenPassword(with: "Внимание",
                                   and: "Вы хотите востановить пароль?") {
            Auth.auth().sendPasswordReset(withEmail: self.emailTextField.text!) { (error) in
                if let error = error as NSError? {
                    switch AuthErrorCode(rawValue: error.code) {
                    case .userNotFound:
                        self.showAlert(with: "Ошибка", and: "Пользователь не найден")
                    case .invalidEmail:
                        self.showAlert(with: "Ошибка", and: "Неверный адрес электронной почты")
                    case .invalidRecipientEmail:
                        self.showAlert(with: "Ошибка", and: "Неверный адрес электронной почты получателя")
                    case .invalidSender:
                        self.showAlert(with: "Ошибка", and: "Не получилось восстановить пароль")
                    case .invalidMessagePayload:
                        self.showAlert(with: "Ошибка", and: "Недопустимые данные сообщения")
                    default:
                        self.showAlert(with: "Ошибка", and: "Вы не указали эл. почту")
                    }
                }
                self.showAlert(with: "Успешно", and: "Письмо с инструкцией по восстановлению пароля отправлено на почту \(self.emailTextField.text ?? "")")
            }
        }
        
    }
}

// MARK: - Setup constraints
extension LoginViewController {
    private func setupConstraints() {
        
        let topStackView = UIStackView(arrangedSubviews: [welcomeLabel, descriptionFTLabel], axis: .vertical, spacing: 20)
        
        let emailStackView = UIStackView(arrangedSubviews: [emailLabel, emailTextField], axis: .vertical, spacing: 5)
        emailTextField.backgroundColor = .systemGray6
        emailTextField.layer.cornerRadius = 5
        
        let passwordStackView = UIStackView(arrangedSubviews: [passwordLabel, passwordTextField], axis: .vertical, spacing: 5)
        passwordTextField.backgroundColor = .systemGray6
        passwordTextField.layer.cornerRadius = 5
        
        let stackView = UIStackView(arrangedSubviews: [googleButton, emailStackView, passwordStackView, loginButton, forgottenButton], axis: .vertical, spacing: 20)
        
        signUpButton.contentHorizontalAlignment = .leading
        let bottomStackView = UIStackView(arrangedSubviews: [needAnAccountLabel, signUpButton], axis: .horizontal, spacing: 10)
        
        loginButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        let footerStackView = UIView()
        footerStackView.backgroundColor = .systemGray6
        footerStackView.layer.borderColor = UIColor.systemGray5.cgColor
        footerStackView.layer.borderWidth = 1
        
        bottomStackView.alignment = .firstBaseline
        
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
        
        NSLayoutConstraint.activate([
            footerStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            footerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            footerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            footerStackView.heightAnchor.constraint(equalToConstant: 95)
        ])
    }
}

// MARK: - SwiftUI
import SwiftUI

struct LoginVCProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        let loginVC = LoginViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<LoginVCProvider.ContainerView>) -> LoginViewController {
            return loginVC
        }
        
        func updateUIViewController(_ uiViewController: LoginVCProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<LoginVCProvider.ContainerView>) {
            
        }
    }
}

// MARK: - show Alert Forgotten Password
extension LoginViewController {
    func showAlertForgottenPassword(with title: String, and message: String, completion: @escaping () -> Void = { }) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Восстановить", style: .destructive) { (_) in completion()}
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
}

// MARK: - UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else {
            passwordTextField.resignFirstResponder()
        }
        return true
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
}
