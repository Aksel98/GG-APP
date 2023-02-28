//
//  UIButtonExtension.swift
//  GG-App
//
//  Created by Aksel Avetisyan on 01.03.23.
//

import UIKit

extension UIButton {
    
    func setEnable() {
        alpha = 1
        isEnabled = true
    }
    
    func setDisable() {
        alpha = 0.5
        isEnabled = false
    }
}
