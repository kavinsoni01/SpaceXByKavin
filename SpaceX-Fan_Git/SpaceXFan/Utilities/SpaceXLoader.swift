//
//  SpaceXLoader.swift
//  SpaceX Fan
//
//  Created by Kavin Soni on 24/06/21.
//

import UIKit
import SVProgressHUD

class SpaceXLoader: NSObject {
    
    static let shared = SpaceXLoader()
    
    override private init() {
        super.init()
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.custom)
        SVProgressHUD.setBackgroundColor(UIColor.Theme.themeColor)
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.dark)
    }
    
    func showLoader(WithMessage message:String = "Loading") -> Void {
        OperationQueue.main.addOperation {
            SVProgressHUD.show(withStatus: message)
        }
    }
    
    func hideLoader() -> Void {
        OperationQueue.main.addOperation {
            SVProgressHUD.dismiss()
        }
    }
}
