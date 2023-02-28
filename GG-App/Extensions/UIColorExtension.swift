//
//  UIColorExtension.swift
//  GG-App
//
//  Created by Aksel Avetisyan on 01.03.23.
//

import UIKit

extension UIColor {
    
    public convenience init?(hexString: String) {
        if hexString.hasPrefix("#") {
            let start = hexString.index(hexString.startIndex, offsetBy: 1)
            let hexColor = hexString[start...]
            
            if hexColor.count == 6 {
                let scanner = Scanner(string: String(hexColor))
                var hexNumber: UInt64 = 0
                if scanner.scanHexInt64(&hexNumber) {
                    let r = (hexNumber & 0xff0000) >> 16
                    let g = (hexNumber & 0xff00) >> 8
                    let b = hexNumber & 0xff
                    
                    self.init(displayP3Red: CGFloat(r) / 0xff, green: CGFloat(g) / 0xff, blue:  CGFloat(b) / 0xff, alpha: 1)
                    return
                }
            }
        } else if hexString.hasPrefix("rgb") {
            let rgbColors = hexString.replacingOccurrences(of: "rgb(", with: "").replacingOccurrences(of: ")", with: "").split(separator: ",")
            if rgbColors.count == 3 {
                self.init(red: CGFloat(Float(rgbColors[0]) ?? 0)/255, green: CGFloat(Float(rgbColors[1]) ?? 0)/255, blue: CGFloat(Float(rgbColors[2]) ?? 0)/255, alpha: 1.0)
                return
            }
            return nil
        }
        
        return nil
    }
    
    static var baseColors: BaseThemeColors {
        return BaseThemeColors()
    }
}
