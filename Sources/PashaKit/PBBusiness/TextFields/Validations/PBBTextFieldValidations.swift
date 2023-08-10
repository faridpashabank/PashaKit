//
//  PBBTextFieldValidations.swift
//  
//
//  Created by Farid Valiyev on 03.08.23.
//

import Foundation

public class PBBTextFieldValidations {
    static func validateEmail(for email: String) -> PBTextFieldValidity {
        print("EMAIL::: \(email)")
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        if emailPred.evaluate(with: email) {
            return .valid
        } else {
            return .invalid("Email is not correct")
        }
    }
    
    static func validatePhone(for phone: String) -> PBTextFieldValidity {

        var phoneRegEx = "(\\+994)+[0-9]{2}+[0-9]{7}"

        let phonePred = NSPredicate(format: "SELF MATCHES %@", phoneRegEx)
        if phonePred.evaluate(with: phone) {
            return .valid
        } else {
            return .invalid("Phone is not correct")
        }
    }
}
