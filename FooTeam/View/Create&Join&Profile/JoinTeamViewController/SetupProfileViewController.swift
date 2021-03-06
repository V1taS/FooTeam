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
    let welcomeLabel = UILabel(
        text: NSLocalizedString("SetupProfileViewControllerWelcomeLabel",
                                comment: "Profile setting"),
        font: .bolt20(),
        textAlignment: .center
    )
    
    let fullImageView = AddAvaPlayersView()
    let nameLabel = UILabel(
        text: NSLocalizedString("SetupProfileViewControllerNameLabel",
                                comment: "Name"),
        font: .markerFel14()
    )
    let positionLabel = UILabel(
        text: NSLocalizedString("SetupProfileViewControllerPositionLabel",
                                comment: "What position do you play??"),
        font: .markerFel14()
    )
    let whoAreYouLabel = UILabel(
        text: NSLocalizedString("SetupProfileViewControllerWhoAreYouLabel",
                                comment: "Who are you?"),
        font: .markerFel14()
    )
    
    let nameTextField = CustomeTextField(
        placeholder: NSLocalizedString("SetupProfileViewControllerNameTextField",
                                       comment: "Andrey Shevchenko")
    )
    let positionPlayerSegmentedControl = UISegmentedControl(
        items: [
            NSLocalizedString("SetupProfileViewControllerPositionSt" ,comment: "ST"),
            NSLocalizedString("SetupProfileViewControllerPositionMC" ,comment: "MC"),
            NSLocalizedString("SetupProfileViewControllerPositionDC" ,comment: "DC"),
            NSLocalizedString("SetupProfileViewControllerPositionGK" ,comment: "GK")
        ]
    )
    let whoAreYouSegmentedControl = UISegmentedControl(
        first: NSLocalizedString("SetupProfileViewControllerPlayer",
                                 comment: "Player"),
        second: NSLocalizedString("SetupProfileViewControllerViewer",
                                  comment: "Viewer")
    )
    
    let goToButton = UIButton(
        title: NSLocalizedString("SetupProfileViewControllerGoToButton",
                                 comment: "To begin"),
        titleColor: .white,
        backgroundColor: .buttonDark(),
        font: .bolt14(),
        cornerRadius: 4,
        borderColor: .textFieldLight()
    )
    
    private let currentUser: User
    
    init(currentUser: User) {
        self.currentUser = currentUser
        super.init(nibName: nil, bundle: nil)
        
        if let username = currentUser.displayName {
            nameTextField.text = username
        }
        
        if let photoURL = currentUser.photoURL {
            fullImageView.circleAvaPlayersImageView.sd_setImage(
                with: photoURL,
                completed: nil
            )
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addKeyboardObserver()
        self.nameTextField.delegate = self
        
        view.backgroundColor = .whiteAndBlack()
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
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @objc private func goToChatsButtonTapped() {
        FirestoreService.shared.saveProfileWith(
            id: currentUser.uid,
            email: currentUser.email!,
            name: nameTextField.text!,
            avatarImage: fullImageView.circleAvaPlayersImageView.image,
            whoAreYou: "\(whoAreYouSegmentedControl.selectedSegmentIndex)",
            positionPlayer: "\(positionPlayerSegmentedControl.selectedSegmentIndex)") { (result) in
            switch result {
            case .success(let player):
                self.showAlert(
                    with: NSLocalizedString("SetupProfileViewControllerSuccessfully",
                                            comment: "Successfully"),
                    and: NSLocalizedString("SetupProfileViewControllerDataIsBackedUp",
                                           comment: "Data is backed up!"),
                    completion: {
                        
                        FirestoreService.shared.getUserDataSimple()
                        
                        if self.whoAreYouSegmentedControl.selectedSegmentIndex == 1 {
                            let joinToFooTeam = UIHostingController(rootView: JoinToTeamView())
                            joinToFooTeam.modalPresentationStyle = .fullScreen
                            self.present(joinToFooTeam, animated: true, completion: nil)
                        } else {
                            let alertController = UIAlertController(
                                title: NSLocalizedString("SetupProfileViewControllerToContinue",
                                                         comment: "To continue"),
                                message: NSLocalizedString("SetupProfileViewControllerJoinOrCreateTeam",
                                                           comment: "join or create a team"),
                                preferredStyle: .actionSheet
                            )
                            
                            let creatTeam = UIAlertAction(
                                title: NSLocalizedString("SetupProfileViewControllerCreateTeam",
                                                         comment: "Create a team"),
                                style: .default
                            ) { _ in
                                let createTeam = CreateTeamViewController(
                                    currentPlayer: player,
                                    currentUser: self.currentUser
                                )
                                createTeam.modalPresentationStyle = .fullScreen
                                self.present(createTeam, animated: true, completion: nil)
                            }
                            
                            let joinTeam = UIAlertAction(
                                title: NSLocalizedString("SetupProfileViewControllerJoinTeam",
                                                         comment: "Join the team"),
                                style: .default
                            ) { _ in
                                let joinToFooTeam = UIHostingController(rootView: JoinToTeamView())
                                joinToFooTeam.modalPresentationStyle = .fullScreen
                                self.present(joinToFooTeam, animated: true, completion: nil)
                            }
                            
                            alertController.addAction(creatTeam)
                            alertController.addAction(joinTeam)
                            self.present(alertController, animated: true, completion: nil)
                        }
                    })
            case .failure(let error):
                self.showAlert(
                    with: NSLocalizedString("SetupProfileViewControllerError",
                                            comment: "Error \(error)"),
                    and: error.localizedDescription
                )
            }
        }
    }
}

// MARK: - Setup constraints
extension SetupProfileViewController {
    private func setupConstraints() {
        
        let nameStackView = UIStackView(
            arrangedSubviews: [nameLabel, nameTextField],
            axis: .vertical,
            spacing: 5
        )
        
        let positionuStackView = UIStackView(
            arrangedSubviews: [positionLabel, positionPlayerSegmentedControl],
            axis: .vertical,
            spacing: 12
        )
        positionPlayerSegmentedControl.selectedSegmentIndex = 0
        
        let whoAreYouStackView = UIStackView(
            arrangedSubviews: [whoAreYouLabel, whoAreYouSegmentedControl],
            axis: .vertical,
            spacing: 12
        )
        
        goToButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
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
            welcomeLabel.topAnchor.constraint(
                equalTo: view.topAnchor,
                constant: 120
            ),
            welcomeLabel.centerXAnchor.constraint(
                equalTo: view.centerXAnchor
            )
        ])
        
        NSLayoutConstraint.activate([
            fullImageView.topAnchor.constraint(
                equalTo: welcomeLabel.bottomAnchor,
                constant: 40
            ),
            fullImageView.centerXAnchor.constraint(
                equalTo: view.centerXAnchor
            )
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: fullImageView.bottomAnchor, constant: 40),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }
}

// MARK: - UIImagePickerControllerDelegate
extension SetupProfileViewController: UINavigationControllerDelegate,
                                      UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[
            UIImagePickerController.InfoKey.originalImage
        ] as? UIImage else { return }
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
