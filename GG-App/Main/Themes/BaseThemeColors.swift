//
//  BaseThemeColors.swift
//  GG-App
//
//  Created by Aksel Avetisyan on 01.03.23.
//

import UIKit

struct BaseThemeColors {
    
    func getWhite() -> UIColor {
        return UIColor(hexString: "#FFFFFF") ?? UIColor()
    }
    
    func getBlack() -> UIColor {
        return UIColor(hexString: "#000000") ?? UIColor()
    }
}
