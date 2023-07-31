//
//  UIFont+Extensions.swift
//  
//
//  Created by Farid Valiyev on 23.07.23.
//

import Foundation
import UIKit

public enum SFProDisplayWeight: String, CaseIterable {
    case light = "SF-Pro-Display-Light"
    case regular = "SF-Pro-Display-Regular"
    case medium = "SF-Pro-Display-Medium"
    case semibold = "SF-Pro-Display-Semibold"
    case bold = "SF-Pro-Display-Bold"
}

public enum SFProTextWeight: String, CaseIterable {
    case light = "SF-Pro-Text-Light"
    case regular = "SF-Pro-Text-Regular"
    case medium = "SF-Pro-Text-Medium"
    case semibold = "SF-Pro-Text-Semibold"
    case bold = "SF-Pro-Text-Bold"
}

public extension UIFont {

    static func sfProDisplay(ofSize: CGFloat, weight: SFProDisplayWeight) -> UIFont {
        guard let customFont = UIFont(name: weight.rawValue, size: ofSize) else {
        return UIFont.systemFont(ofSize: ofSize)
      }
      return customFont
    }
    
    static func sfProText(ofSize: CGFloat, weight: SFProTextWeight) -> UIFont {
        guard let customFont = UIFont(name: weight.rawValue, size: ofSize) else {
        return UIFont.systemFont(ofSize: ofSize)
      }
      return customFont
    }
    
}
