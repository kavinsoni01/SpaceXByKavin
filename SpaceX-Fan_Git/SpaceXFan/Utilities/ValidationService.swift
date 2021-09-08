//
//  ValidationService.swift
//  SpaceX Fan
//
//  Created by Kavin Soni on 27/06/21.
//

import UIKit
import Foundation


struct ValidationService {
    
    func validatePassword(_ password:String?) throws -> String {
        guard let password = password else {throw ValidationError.enterPassword}
        guard password != "" else {throw ValidationError.enterPassword}
        guard password.count >= 6 else {throw ValidationError.passwordTooShort}

        return password
    }
    
    
   
    func isEmptyCheckEmail(_ text:String?) throws -> String  {
      
            guard let textField = text else {throw ValidationError.enterEmail}
            guard textField != ""  else {throw ValidationError.enterEmail}
            
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            let isValidEmail = emailTest.evaluate(with: text)
            if isValidEmail == false{
                throw ValidationError.enterValidEmail
            }
            return textField
        
    }
    
    
    
    
//    func isEmptyCheckPassword(_ text:String?) throws -> String  {
//
//            guard let textField = text else {throw ValidationError.enterPassword}
//            guard textField != ""  else {throw ValidationError.enterPassword}
//            return textField
//
//    }
}

enum ValidationError:LocalizedError {
    
    case enterEmail
    case enterPassword
    case passwordTooShort
    case enterValidEmail


    var errorDescription: String? {
        switch self {
       
        case .enterEmail:
            return "Please enter email."
        case .enterPassword:
            return "Please enter password."
            
        case .passwordTooShort:
            return "Your password is too short."
       
        case .enterValidEmail:
            return "Please enter valid email."
        }
    }
}
