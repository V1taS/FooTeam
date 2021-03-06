//
//  CreateTeamViewController.swift
//  FooTeam
//
//  Created by Виталий Сосин on 10.08.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import UIKit
import SwiftUI
import FirebaseAuth

class CreateTeamViewController: UIViewController {
    let welcomeLabel = UILabel(
        text: NSLocalizedString("CreateTeamViewControllerWelcomeLabel",
                                comment: "Creating a team"),
        font: .bolt20(),
        textAlignment: .center
    )
    let fullImageView = AddAvaTeamsView()
    let nameLabel = UILabel(
        text: NSLocalizedString("CreateTeamViewControllerNameLabel",
                                comment: "Team name"),
        font: .markerFel14()
    )
    let cityLabel = UILabel(
        text: NSLocalizedString("CreateTeamViewControllerCityLabel",
                                comment: "Location"),
        font: .markerFel14()
    )
    let TypeTeamLabel = UILabel(
        text: NSLocalizedString("CreateTeamViewControllerTypeTeamLabel",
                                comment: "The command type"),
        font: .markerFel14()
    )
    
    let nameTextField = CustomeTextField(placeholder: " FC ASC")
    let cityTextField = CustomeTextField(placeholder: " Khimki")
    
    let availabilityTeamSegmentedControl = UISegmentedControl(
        first: NSLocalizedString("CreateTeamViewControllerTypeTeamOpen",
                                 comment: "Open"),
        second: NSLocalizedString("CreateTeamViewControllerTypeTeamClose",
                                  comment: "Private")
    )
    let goToButton = UIButton(
        title: NSLocalizedString("CreateTeamViewControllerGoToButton",
                                 comment: "Create"),
        titleColor: .white,
        backgroundColor: .buttonDark(),
        font: .bolt14(),
        cornerRadius: 4,
        borderColor: .textFieldLight()
    )
    
    private let currentPlayer: Player
    private let currentUser: User
    
    init(currentPlayer: Player, currentUser: User) {
        self.currentPlayer = currentPlayer
        self.currentUser = currentUser
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addKeyboardObserver()
        
        self.nameTextField.delegate = self
        self.cityTextField.delegate = self
        
        view.backgroundColor = .whiteAndBlack()
        setupConstraints()
        goToButton.addTarget(self, action: #selector(goToChatsButtonTapped), for: .touchUpInside)
        fullImageView.plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
    }
}

// MARK: - Actions
extension CreateTeamViewController {
    @objc private func plusButtonTapped() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @objc private func goToChatsButtonTapped() {
        FirestoreService.shared.saveTeamWith(
            avatarTeam: fullImageView.circleAvaTeamsImageView.image,
            teamName: nameTextField.text,
            location: cityTextField.text,
            teamType: "\((self.availabilityTeamSegmentedControl.selectedSegmentIndex))",
            rating: 0,
            player: currentPlayer
        ) { result in
            switch result {
            case .success(_):
                FirestoreService.shared.getUserDataSimple()
                
                self.showAlert(
                    with: NSLocalizedString("CreateTeamViewControllerSuccessfully",
                                            comment: "Successfully"),
                    and: NSLocalizedString("CreateTeamViewControllerYouCreatedTeam",
                                           comment: "You created a team!")
                ) {
                    let mainContentFooTeam = UIHostingController(rootView: TabViewFooTeam())
                    mainContentFooTeam.modalPresentationStyle = .fullScreen
                    self.present(mainContentFooTeam, animated: true, completion: nil)
                }
            case .failure(let error):
                self.showAlert(
                    with: NSLocalizedString("CreateTeamViewControllerError",
                                            comment: "Error"),
                    and: error.localizedDescription
                )
            }
        }
    }
}

// MARK: - Setup constraints
extension CreateTeamViewController {
    private func setupConstraints() {
        let nameStackView = UIStackView(
            arrangedSubviews: [nameLabel,
                               nameTextField],
            axis: .vertical,
            spacing: 5
        )
        let positionuStackView = UIStackView(
            arrangedSubviews: [cityLabel,
                               cityTextField],
            axis: .vertical,
            spacing: 12
        )
        let whoAreYouStackView = UIStackView(
            arrangedSubviews: [TypeTeamLabel,
                               availabilityTeamSegmentedControl],
            axis: .vertical,
            spacing: 12
        )
        
        goToButton.heightAnchor.constraint(
            equalToConstant: 60
        ).isActive = true
        
        let stackView = UIStackView(
            arrangedSubviews: [nameStackView,
                               positionuStackView,
                               whoAreYouStackView,
                               goToButton],
            axis: .vertical,
            spacing: 20
        )
        
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
extension CreateTeamViewController: UINavigationControllerDelegate,
                                    UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [
                                UIImagePickerController.InfoKey : Any
                                ]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[
            UIImagePickerController.InfoKey.originalImage
        ] as? UIImage else { return }
        fullImageView.circleAvaTeamsImageView.image = image
    }
}

// MARK: - UITextFieldDelegate
extension CreateTeamViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameTextField{
            cityTextField.becomeFirstResponder()
        } else {
            cityTextField.resignFirstResponder()
        }
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
}
