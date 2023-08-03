//
//  UIFont+Extensions.swift
//  
//
//  Created by Farid Valiyev on 23.07.23.
//

import Foundation
import UIKit

public enum SFProDisplayWeight: String, CaseIterable {
    case light = "Light"
    case regular = "Regular"
    case medium = "Medium"
    case semibold = "Semibold"
    case bold = "Bold"
}

public enum SFProTextWeight: String, CaseIterable {
    case light = "Light"
    case regular = "Regular"
    case medium = "Medium"
    case semibold = "Semibold"
    case bold = "Bold"
}

public extension UIFont {

    static func sfProDisplay(ofSize: CGFloat, weight: SFProDisplayWeight) -> UIFont {
        print("weight::: \(weight.rawValue)")

        guard let customFont = UIFont(name: "SFProDisplay-\(weight.rawValue)", size: ofSize) else {
            print("else weight::: \(weight.rawValue)")
        return UIFont.systemFont(ofSize: ofSize)
      }
      return customFont
    }
    
    static func sfProText(ofSize: CGFloat, weight: SFProTextWeight) -> UIFont {
        guard let customFont = UIFont(name: "SFProText-\(weight.rawValue)", size: ofSize) else {
        return UIFont.systemFont(ofSize: ofSize)
      }
      return customFont
    }
    
    static func registerSFProDisplayFonts() {
        SFProDisplayWeight.allCases.forEach {
           registerFont(bundle: .module, fontName: "SFProDisplay" + $0.rawValue, fontExtension: "otf")
       }
    }
   
    static func registerSFProTextFonts() {
       SFProTextWeight.allCases.forEach {
          registerFont(bundle: .module, fontName: "SFProText" + $0.rawValue, fontExtension: "otf")
       }
    }
    
    static func registerFont(bundle: Bundle, fontName: String, fontExtension: String) {

        print("bundle: \(bundle)")
        print("font: \(fontName)")
        
        guard let fontURL = bundle.url(forResource: fontName, withExtension: fontExtension),
              let fontDataProvider = CGDataProvider(url: fontURL as CFURL),
              let font = CGFont(fontDataProvider) else {
                  fatalError("Couldn't create font from data")
        }

        print("fontURL: \(fontURL)")
        print("fontDataProvider: \(fontDataProvider)")
        print("font: \(font)")
        
        var error: Unmanaged<CFError>?

        CTFontManagerRegisterGraphicsFont(font, &error)
    }
    
}
