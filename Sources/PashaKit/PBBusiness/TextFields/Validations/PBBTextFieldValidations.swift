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
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        if emailPred.evaluate(with: email) {
            return .valid
        } else {
            return .invalid("Email is not correct")
        }
    }
}
