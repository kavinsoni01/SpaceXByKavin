//
//  SpaceXButton.swift
//  SpaceX Fan
//
//  Created by Kavin Soni on 27/06/21.
//

import UIKit

enum buttonType {

    case none
    case blueButton
    case blueBorderButton
}

class SpaceXButton: UIButton {
    
    var btnType:buttonType = .none{
           didSet{
               commonInit()
           }
       }

 
    //INIT
           override init(frame: CGRect) {
               super.init(frame: frame)
           }
           required init?(coder aDecoder: NSCoder) {
               super.init(coder: aDecoder)
               commonInit()
           }
           
           override func awakeFromNib() {
               super.awakeFromNib()
               commonInit()
           }
           
           private func commonInit()
           {
               self.isExclusiveTouch = true
  //             initialize()

              self.titleLabel?.font = UIFont.appFont_Bold(Size: CGFloat(self.titleLabel?.font.pointSize ?? 15.0))

                                     
                  switch btnType {
                       
                  case .none:
                      break
                 
                      
                     
                          
                  case .blueBorderButton:
                      
                      DispatchQueue.main.async {
                          self.layer.cornerRadius = 2//self.layer.frame.size.height/1.7
                          self.layer.masksToBounds = true
                          self.layer.borderWidth = 1
                          self.layer.borderColor = UIColor.Theme.themeColor.cgColor
                      }
                      
                      self.backgroundColor = UIColor.clear
                      self.setTitleColor(UIColor.Theme.themeColor, for: .normal)

                  case .blueButton:
                      self.layer.cornerRadius = 2//self.layer.frame.size.height/1.7
                      self.layer.masksToBounds = true
                      self.backgroundColor = UIColor.Theme.themeColor
                      self.setTitleColor(UIColor.white, for: .normal)
                      self.titleLabel?.font = UIFont.appFont_FontMedium(Size: CGFloat(self.titleLabel?.font.pointSize ?? 15.0))
                  }
            }
  }

