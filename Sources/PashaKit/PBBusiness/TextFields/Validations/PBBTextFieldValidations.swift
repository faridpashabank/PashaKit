//
//  PBBTextFieldValidations.swift
//  
//
//  Created by Farid Valiyev on 03.08.23.
//

import Foundation

public class PBBTextFieldValidations {
    static func validateEmail(for email: String) -> Bool {
        print("EMAIL::: \(email)")
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
//        {
//            return .valid
//        } else {
//            return .invalid("Email is not correct")
//        }
    }
    
    static func validatePhone(for phone: String) -> Bool {

        var phoneRegEx = "(\\+994)+[0-9]{2}+[0-9]{7}"

        let phonePred = NSPredicate(format: "SELF MATCHES %@", phoneRegEx)
        return phonePred.evaluate(with: phone)
//        {
//            return .valid
//        } else {
//            return .invalid("Phone is not correct")
//        }
    }
    
    static func validateCardNumber(for pan: String) -> Bool {
        return pan.isValidCardNumber()
//        {
//            return .valid
//        } else {
//            return .invalid("PAN is not correct")
//        }
    }
}
