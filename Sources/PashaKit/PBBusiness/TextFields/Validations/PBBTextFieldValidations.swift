//
//  PBBTextFieldValidations.swift
//  
//
//  Created by Farid Valiyev on 03.08.23.
//

import Foundation

public class PBBTextFieldValidations {
    static func validateEmail(email: String) -> PBTextFieldValidity {
        print("EMAIL::: \(email)")
        return .invalid("Fuck you bitch")
    }
}
