//
//  UIColor + Extension.swift
//  FooTeam
//
//  Created by Виталий Сосин on 12.07.2020.
//  Copyright © 2020 Vitalii Sosin. All rights reserved.
//

import UIKit

extension UIColor {
    
    static func buttonRed() -> UIColor {
        return #colorLiteral(red: 0.8156862745, green: 0.007843137255, blue: 0.1058823529, alpha: 1)
    }
    
    static func mainWhite() -> UIColor {
        return UIColor(named: "mainWhite")!
    }
    
    static func buttonDark() -> UIColor {
        return UIColor(named: "buttonDark")!
    }
    
    static func textFieldLight() -> UIColor {
        return UIColor(named: "textFieldLight")!
    }
    
    static func blackAndWhite() -> UIColor {
        return UIColor(named: "BlackAndWhite")!
    }
    
    static func whiteAndBlack() -> UIColor {
        return UIColor(named: "WhiteAndBlack")!
    }
}
