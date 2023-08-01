//
//  UIFont+Extensions.swift
//  
//
//  Created by Farid Valiyev on 23.07.23.
//

import Foundation
import UIKit

public enum SFProDisplayWeight: String, CaseIterable {
    case light = "SFProDisplay-Light"
    case regular = "SFProDisplay-Regular"
    case medium = "SFProDisplay-Medium"
    case semibold = "SFProDisplay-Semibold"
    case bold = "SFProDisplay-Bold"
}

public enum SFProTextWeight: String, CaseIterable {
    case light = "SFProText-Light"
    case regular = "SFProText-Regular"
    case medium = "SFProText-Medium"
    case semibold = "SFProText-Semibold"
    case bold = "SFProText-Bold"
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
    
    static func registerSFProDisplayFonts() {
        SFProDisplayWeight.allCases.forEach {
           registerFont(bundle: .module, fontName: $0.rawValue, fontExtension: "otf")
       }
    }
   
    static func registerSFProTextFonts() {
       SFProTextWeight.allCases.forEach {
          registerFont(bundle: .module, fontName: $0.rawValue, fontExtension: "otf")
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
