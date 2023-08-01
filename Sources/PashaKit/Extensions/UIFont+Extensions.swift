//
//  UIFont+Extensions.swift
//  
//
//  Created by Farid Valiyev on 23.07.23.
//

import Foundation
import UIKit

public enum SFProDisplayWeight: String, CaseIterable {
    case light = "SFProDisplayLight"
    case regular = "SFProDisplayRegular"
    case medium = "SFProDisplayMedium"
    case semibold = "SFProDisplaySemibold"
    case bold = "SFProDisplayBold"
}

public enum SFProTextWeight: String, CaseIterable {
    case light = "SFProTextLight"
    case regular = "SFProTextRegular"
    case medium = "SFProTextMedium"
    case semibold = "SFProTextSemibold"
    case bold = "SFProTextBold"
}

public extension UIFont {

    static func sfProDisplay(ofSize: CGFloat, weight: SFProDisplayWeight) -> UIFont {
        print("weight::: \(weight.rawValue)")
        guard let customFont = UIFont(name: weight.rawValue, size: ofSize) else {
            print("else weight::: \(weight.rawValue)")
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
