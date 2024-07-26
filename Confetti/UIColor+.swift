//
//  UIColor+.swift
//  Confetti
//
//  Created by Scott Richards on 7/18/24.
//

import Foundation
import UIKit

extension UIColor {
    /**
     Create a UIColor from a 6 character hex string with an optional '#' prefix. Optional alpha component is defaulted to 1.0.
     - parameters:
     - hexString: A six character hex representation of a color with or without a leading '#' character.
     - alpha: Optional alpha value for the color. Defaults to 1.0.
     */
    @objc convenience init?(hexString: String, alpha: CGFloat = 1.0) {
        guard hexString.count == 6 || (hexString.count == 7 && hexString.hasPrefix("#")) else {
            return nil
        }
        
        var hexInt: UInt32 = 0
        
        let scanner: Scanner = Scanner(string: hexString)
        scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#")
        
        if !scanner.scanHexInt32(&hexInt) {
            return nil
        }
        
        let red = CGFloat((hexInt & 0xff0000) >> 16) / 255.0
        let green = CGFloat((hexInt & 0xff00) >> 8) / 255.0
        let blue = CGFloat((hexInt & 0xff) >> 0) / 255.0
        let alpha = alpha
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
