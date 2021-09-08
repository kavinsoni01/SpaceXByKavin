//
//  LoginViewController.swift
//  SpaceXFan
//
//  Created by Kavin Soni on 02/09/21.
//

import UIKit

class LoginViewController: BaseViewController {
   
    

    //VARIABLE
    var btnEye = UIButton(type: .custom)
//    private let validationService:ValidationService
    var isShowPassword:Bool = false
    private var viewModel:LoginViewModel!

    //Outlets
    @IBOutlet weak var txtEmail: SpaceXTextField!
    @IBOutlet weak var txtPassword: SpaceXTextField!
    @IBOutlet weak var btnLogin: SpaceXButton!
    @IBOutlet weak var btnContinue: SpaceXButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
            //Setup UI
        self.setupUI()
        self.viewModel = LoginViewModel(output: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.hidenavigationBar()
    }
    
    
    //MARK: Setup UI
    func setupUI() -> Void {
        self.txtEmail.leftIcon = UIImage.init(named:"email")
        self.txtEmail.textFieldUIType = .normal
        self.txtPassword.leftIcon = UIImage.init(named:"padlock")
        self.txtPassword.textFieldUIType = .normal
        self.txtPassword.textFieldType = .password
        self.btnLogin.btnType = .blueButton
        self.btnContinue.btnType = .blueBorderButton
        self.setPasswordVisableMethod()
    }
    
    //MARK: Password visable methods
    func setPasswordVisableMethod(){
        btnEye.setImage(UIImage(named: "eyeClose"), for: .normal)
        btnEye.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        btnEye.frame = CGRect(x: CGFloat(txtPassword.frame.size.width - 22), y: CGFloat(5), width: CGFloat(15), height: CGFloat(15))
        btnEye.addTarget(self, action: #selector(self.btnShowPasswordInPWD), for: .touchUpInside)
        txtPassword.rightView = btnEye
        txtPassword.rightViewMode = .always
    }
    
    //MARK: Button to visable password Or Hide Password
    @objc func btnShowPasswordInPWD() -> Void
    {
        if isShowPassword == false{
            self.txtPassword.isSecureTextEntry = false
            isShowPassword = true
            self.btnEye.setImage(UIImage(named: "eyeOpen"), for: .normal)
            
        }else{
            self.btnEye.setImage(UIImage(named: "eyeClose"), for: .normal)
            self.txtPassword.isSecureTextEntry = true
            isShowPassword = false
        }
    }
  
    
    
    //MARK: Button Action
        @IBAction func btnLoginClicked(_ sender: Any) {
            self.viewModel.loginWithFirebase(email: self.txtEmail.text!, password: self.txtPassword.text!)
        }
        @IBAction func btnContinueClicked(_ sender: Any) {
            let tabBar:TabBarController = UIStoryboard(storyboard: .Main).instantiateViewController()
            self.navigationController?.pushViewController(tabBar, animated: true)
        }
}


extension LoginViewController: LoginViewModelOutputProtocol  {

func loginSuccess() {
    let tabBar:TabBarController = UIStoryboard(storyboard: .Main).instantiateViewController()
    self.navigationController?.pushViewController(tabBar, animated: true)
}

func didFailToLogin(withError error: Error) {
    print(error)
}
}
