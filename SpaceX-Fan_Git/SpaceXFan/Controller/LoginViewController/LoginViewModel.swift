//
//  LoginViewModel.swift
//  SpaceXFan
//
//  Created by Kavin Soni on 03/09/21.
//

import UIKit



protocol LoginViewModelInputProtocol {
    func loginWithFirebase(email: String, password: String) -> Void
}

protocol LoginViewModelOutputProtocol {
    func loginSuccess() -> Void
    func didFailToLogin(withError error:Error) -> Void
}


class LoginViewModel: LoginViewModelInputProtocol {
    private let spaceXRepository:SpaceXAuthRepository
    
    private(set) var rockets:[RocketInfo] = []
    private let output:LoginViewModelOutputProtocol
    init(
        output:LoginViewModelOutputProtocol,
        spaceXRepository:SpaceXAuthRepository = SpaceXAuthRepository()
    ) {
        self.spaceXRepository = spaceXRepository
        self.output = output
    }
    
    func loginWithFirebase(email: String, password: String) -> Void {
        self.spaceXRepository.loginFirebaseAuthMethod(email: email, password: password) { result in
                        switch result {
                            case .success:
                                self.output.loginSuccess()
                            case .failure(let error):
                                self.output.didFailToLogin(withError: error)
                        }
                    }
//        self.spaceXRepository.getRockets { result in
//            switch result {
//                case .success(let rocketsInfo):
//                    self.rockets = rocketsInfo
//                    self.output.didReceive(rocketsInfo: rocketsInfo)
//                case .failure(let error):
//                    self.output.didFailToReceiveRocketsInfo(withError: error)
//            }
//        }
    }
}
