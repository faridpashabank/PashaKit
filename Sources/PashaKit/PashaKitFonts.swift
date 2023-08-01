//
//  PashaKitFonts.swift
//  
//
//  Created by Farid Valiyev on 31.07.23.
//

import Foundation
import UIKit

public struct PashaKitFonts {
     public static func registerSFProDisplayFonts() {
         SFProDisplayWeight.allCases.forEach {
            registerFont(bundle: .module, fontName: $0.rawValue, fontExtension: "otf")
        }
     }
    
    public static func registerSFProTextFonts() {
        SFProTextWeight.allCases.forEach {
           registerFont(bundle: .module, fontName: $0.rawValue, fontExtension: "otf")
       }
    }

    fileprivate static func registerFont(bundle: Bundle, fontName: String, fontExtension: String) {

//        print("bundle: \(bundle)")
//        print("font: \(fontName)")
        
        guard let fontURL = bundle.url(forResource: fontName, withExtension: fontExtension),
              let fontDataProvider = CGDataProvider(url: fontURL as CFURL),
              let font = CGFont(fontDataProvider) else {
                  fatalError("Couldn't create font from data")
        }

        var error: Unmanaged<CFError>?

        CTFontManagerRegisterGraphicsFont(font, &error)
    }
}
