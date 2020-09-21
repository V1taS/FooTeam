//
//  SetupProfileViewController.swift
//  FooTeam
//
//  Created by Виталий Сосин on 13.07.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import SwiftUI
import FirebaseAuth
import SDWebImage

class SetupProfileViewController: UIViewController {
    
    let welcomeLabel = UILabel(text: "Настройка профиля", font: .bolt20(), textAlignment: .center)
    
    let fullImageView = AddAvaPlayersView()
    
    let nameLabel = UILabel(text: "Имя", font: .markerFel14())
    let positionLabel = UILabel(text: "На какой позиции играешь??", font: .markerFel14())
    let whoAreYouLabel = UILabel(text: "Кто ты?", font: .markerFel14())
    
    let nameTextField = CustomeTextField(placeholder: " Андрей Шевченко")
    let positionPlayerSegmentedControl = UISegmentedControl(items: ["ФРВ", "ЦП", "ЦЗ", "ВРТ"])
    let whoAreYouSegmentedControl = UISegmentedControl(first: "Игрок", second: "Зритель")
    
    let goToButton = UIButton(title: "Начать", titleColor: .white, backgroundColor: .buttonDark(), font: .bolt14(), cornerRadius: 4)
    
    private let currentUser: User
    
    init(currentUser: User) {
        self.currentUser = currentUser
        super.init(nibName: nil, bundle: nil)
        
        if let username = currentUser.displayName {
            nameTextField.text = username
        }
        
        if let photoURL = currentUser.photoURL {
            fullImageView.circleAvaPlayersImageView.sd_setImage(with: photoURL, completed: nil)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.nameTextField.delegate = self
        
        view.backgroundColor = .white
        setupConstraints()
        goToButton.addTarget(self, action: #selector(goToChatsButtonTapped), for: .touchUpInside)
        fullImageView.plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        whoAreYouSegmentedControl.addTarget(self, action: #selector(segmentedValueChanged), for: .valueChanged)
    }
}

// MARK: - Actions
extension SetupProfileViewController {
    
    @objc func segmentedValueChanged() {
        if whoAreYouSegmentedControl.selectedSegmentIndex == 1 {
            positionPlayerSegmentedControl.isEnabled = false
        } else {
            positionPlayerSegmentedControl.isEnabled = true
        }
    }
    
    @objc private func plusButtonTapped() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @objc private func goToChatsButtonTapped() {
        FirestoreService.shared.saveProfileWith(
            id: currentUser.uid,
            email: currentUser.email!,
            name: nameTextField.text!,
            avatarImage: fullImageView.circleAvaPlayersImageView.image,
            whoAreYou: whoAreYouSegmentedControl.titleForSegment(at: whoAreYouSegmentedControl.selectedSegmentIndex)!, positionPlayer: positionPlayerSegmentedControl.titleForSegment(at: positionPlayerSegmentedControl.selectedSegmentIndex)!) { (result) in
                switch result {
                case .success(let player):
                    self.showAlert(with: "Успешно!", and: "Данные сохранены!", completion: {
                        
                        FirestoreService.shared.getUserData(user: self.currentUser) { _ in }
                        
                        if self.whoAreYouSegmentedControl.titleForSegment(at: self.whoAreYouSegmentedControl.selectedSegmentIndex) == "Зритель" {
                            let mainContentFooTeam = UIHostingController(rootView: TabViewFooTeam())
                            mainContentFooTeam.modalPresentationStyle = .fullScreen
                            
                        } else {
                            
                            let alertController = UIAlertController(title: "Чтобы продолжить", message: "присоединись или создай команду", preferredStyle: .actionSheet)
                            
                            let creatTeam = UIAlertAction(title: "Создать команду", style: .default) { _ in
                                let createTeam = CreateTeamViewController(currentPlayer: player, currentUser: self.currentUser)
                                createTeam.modalPresentationStyle = .fullScreen
                                self.present(createTeam, animated: true, completion: nil)
                            }
                            
                            let joinTeam = UIAlertAction(title: "Присоединиться к команде", style: .default) { _ in
                                let joinToFooTeam = UIHostingController(rootView: JoinToTeamView())
                                joinToFooTeam.modalPresentationStyle = .fullScreen
                                self.present(joinToFooTeam, animated: true, completion: nil)
                            }
                            
                            let skipTeam = UIAlertAction(title: "Пропустить и продолжить", style: .destructive) { _ in
                                let mainContentFooTeam = UIHostingController(rootView: TabViewFooTeam())
                                mainContentFooTeam.modalPresentationStyle = .fullScreen
                                self.present(mainContentFooTeam, animated: true, completion: nil)
                            }
                            alertController.addAction(creatTeam)
                            alertController.addAction(joinTeam)
                            alertController.addAction(skipTeam)
                            self.present(alertController, animated: true, completion: nil)
                        }
                    })
                case .failure(let error):
                    self.showAlert(with: "Ошибка! \(error)", and: error.localizedDescription)
                }
        }
    }
}

// MARK: - Setup constraints
extension SetupProfileViewController {
    private func setupConstraints() {
        
        let nameStackView = UIStackView(arrangedSubviews: [nameLabel, nameTextField], axis: .vertical, spacing: 5)
        
        let positionuStackView = UIStackView(arrangedSubviews: [positionLabel, positionPlayerSegmentedControl], axis: .vertical, spacing: 12)
        positionPlayerSegmentedControl.selectedSegmentIndex = 0
        
        let whoAreYouStackView = UIStackView(arrangedSubviews: [whoAreYouLabel, whoAreYouSegmentedControl], axis: .vertical, spacing: 12)
        
        goToButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        let stackView = UIStackView(arrangedSubviews: [nameStackView, positionuStackView, whoAreYouStackView, goToButton], axis: .vertical, spacing: 20)
        
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        fullImageView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(welcomeLabel)
        view.addSubview(fullImageView)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            fullImageView.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 40),
            fullImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: fullImageView.bottomAnchor, constant: 40),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }
}

// MARK: - UIImagePickerControllerDelegate
extension SetupProfileViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        fullImageView.circleAvaPlayersImageView.image = image
    }
}

// MARK: - UITextFieldDelegate
extension SetupProfileViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
}
