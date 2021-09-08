//
//  AuthenticationService.swift
//  SpaceXFan
//
//  Created by kavin Soni on 02/09/21.
//

import Foundation

protocol SpaceXAuthenticationServiceProtocol {

    func loginFirebaseAuthMethod(email:String,password:String , completion: @escaping ((Result<Bool, Error>) -> Void))
    
}


class SpaceXAuthenticationService: BaseLocalService, SpaceXAuthenticationServiceProtocol {
    
    
    func loginFirebaseAuthMethod(email: String, password: String, completion: @escaping ((Result<Bool, Error>) -> Void)) {
        
    }
    
}
