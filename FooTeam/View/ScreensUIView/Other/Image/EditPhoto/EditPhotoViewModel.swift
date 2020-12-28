//
//  EditPhotoViewModel.swift
//  FooTeam
//
//  Created by Виталий Сосин on 04.10.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import UIKit
import Combine

protocol EditPhotoViewModelProtocol {
    var isShowPhotoLibrary: Bool { get }
    var image: UIImage { get }
    var player: Player { get }
}

class EditPhotoViewModel: EditPhotoViewModelProtocol, ObservableObject {
    @Published var player: Player = DefaultPlayer.shared.player
    @Published var isShowPhotoLibrary = false
    @Published var image = UIImage()
}
