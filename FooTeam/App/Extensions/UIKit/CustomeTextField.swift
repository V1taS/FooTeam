//
//  OneLineTextField.swift
//  FooTeam
//
//  Created by Виталий Сосин on 13.07.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import UIKit

class CustomeTextField: UITextField {
    convenience init(font: UIFont? = .avenir20(), placeholder: String? = "", textColor: UIColor? = .blackAndWhite(), isSecure: Bool = false, backgroundColor: UIColor? = .systemGray6, cornerRadius: CGFloat = 5, autocapitalizationType: UITextAutocapitalizationType = .none) {
        self.init()
        
        self.font = font
        self.placeholder = placeholder
        self.textColor = textColor
        self.isSecureTextEntry = isSecure
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = cornerRadius
        self.autocapitalizationType = autocapitalizationType
        
        self.borderStyle = .none
        self.translatesAutoresizingMaskIntoConstraints = false
        
        var bottomView = UIView()
        bottomView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        bottomView.backgroundColor = .systemGray2
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(bottomView)
        
        NSLayoutConstraint.activate([
            bottomView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            bottomView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
}
