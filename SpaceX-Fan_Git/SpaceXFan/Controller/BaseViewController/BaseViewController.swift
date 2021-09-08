//
//  BaseViewController.swift
//  SpaceXFan
//
//  Created by Kavin Soni on 03/09/21.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //set navigation color
        self.navigationController?.navigationBar.barTintColor = UIColor.Theme.themeColor
        let attrs = [
                  NSAttributedString.Key.font: UIFont.font_bold(18)
                  ,NSAttributedString.Key.foregroundColor:UIColor.white
              ]
              
              UINavigationBar.appearance().titleTextAttributes = attrs
              navigationController?.navigationBar.titleTextAttributes = attrs
        
        
    }
    
    func setTitleNavigationController(text: String){
        UINavigationBar.appearance().tintColor = .black
        UINavigationBar.appearance().backgroundColor = .black
        navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.title = text
    }
       
    
    
    func setRightBarButton(img: UIImage?) {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: img?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(RightBarBtnAction))
    }
    
        
    func setLeftBarButton(img: UIImage?) {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: img?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(leftBarBtnAction))
    }
    
    func hidenavigationBar(){
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func showNavigationBar(){
        self.navigationController!.setNavigationBarHidden(false, animated: true)
    }
    
    
    func hideLeftBarBtn() {
        self.navigationItem.leftBarButtonItem = nil
    }
    
    func hideLeftSideButtonBack(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
    }
    func hiderightSideButtonBack(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
    }
    @objc func leftBarBtnAction() {
        print("left back")
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    @objc func RightBarBtnAction() {
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func createEmptyTableView(tblView:UITableView) -> Void {
        let messageLabel = UILabel()//UILabel(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.size.height/2))
        messageLabel.text = "No Record Found"
        messageLabel.textColor = UIColor.black
//            messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.font_bold(26)
        tblView.backgroundView = messageLabel
        tblView.backgroundView?.backgroundColor = UIColor.white
    }
}
