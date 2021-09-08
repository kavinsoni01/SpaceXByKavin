//
//  SpaceXAuthRepository.swift
//  SpaceXFan
//
//  Created by Kavin Soni on 03/09/21.
//

import UIKit
import FirebaseAuth
import FirebaseAnalytics

protocol SpaceXAuthRepositoryProtocol:AnyObject {
  
    func loginFirebaseAuthMethod(email:String,password:String , completion: @escaping ((Result<Bool, Error>) -> Void))

}


class SpaceXAuthRepository: SpaceXAuthRepositoryProtocol {
   
    private let authenticationService:SpaceXAuthenticationServiceProtocol
//    private let validationService:ValidationService!

    init(
        authenticationService:SpaceXAuthenticationServiceProtocol = SpaceXAuthenticationService()

    ) {
        self.authenticationService = authenticationService
    }
    
    func loginFirebaseAuthMethod(email: String, password: String, completion: @escaping ((Result<Bool, Error>) -> Void)) {
                do{
                    let emailStr = try self.isEmptyCheckEmail(email)
                    let passwordStr = try self.validatePassword(password)
                    SpaceXLoader.shared.showLoader()
        
                    Auth.auth().signIn(withEmail: emailStr, password: passwordStr) { [weak self] authResult, error in
        //              guard let strongSelf = self else { return }
                        if error != nil{
                            SpaceXLoader.shared.hideLoader()
                            completion(.failure(error!))
                            SpaceXLoader.shared.hideLoader()
                            UIAlertController.alert(message: error!.localizedDescription)
                        }else{
        
                            Analytics.logEvent(AnalyticsEventEcommercePurchase, parameters: [
                                "eventName": "Login",
                                "email": "\(email)",
                                "password":"\(password)"
                            ])
        
        
                            SpaceXLoader.shared.hideLoader()
                            UserDefaults.standard.set(true, forKey: "isLogin") //Bool
                            UserDefaults.standard.synchronize()
                            completion(.success(true))

                        }
                    }
        
                }catch {
                    SpaceXLoader.shared.hideLoader()
                    UIAlertController.alert(message: error.localizedDescription)
                    completion(.failure(error))
                }
        
                //kavin@mailinator.com
                //1234.Abc
        
        //        Auth.auth().createUser(withEmail: "kavin@mailinator.com", password: "1234.Abc") { authResult, error in
        //          // ...
        //            print(authResult)
        //        }
        
            }
    
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
    
}
