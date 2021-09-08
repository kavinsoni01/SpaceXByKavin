//
//  SpaceXLabel.swift
//  SpaceX Fan
//
//  Created by Kavin Soni on 23/06/21.
//

import UIKit

enum FontType {
    case bold
    case medium
    case regular
    case thin
    case semibold
}


class SpaceXLabel: UILabel {
    
    var fontType:FontType = .regular
    
    override func awakeFromNib() {
  
        super.awakeFromNib()
//        initialize()
//        self.text = self.text?.localized
                
        switch fontType .self {
      
        case .bold:
            self.font = UIFont.appFont_FontExtraBold(Size: CGFloat(self.font.pointSize))

        case .medium:
            self.font = UIFont.appFont_FontMedium(Size: CGFloat(self.font.pointSize))

        case .regular:
            self.font = UIFont.appFont_FontRegular(Size: CGFloat(self.font.pointSize))

        case .thin:
            self.font = UIFont.appFont_FontThin(Size: CGFloat(self.font.pointSize))

        case .semibold:
            self.font = UIFont.appFont_FontSemiBold(Size: CGFloat(self.font.pointSize))

//        @unknown default:
//            self.font = UIFont.appFont_FontRegular(Size: CGFloat(self.font.pointSize))
        }
        
        
      
   }

    override var intrinsicContentSize: CGSize {
         let size = super.intrinsicContentSize
         
         // you can change 'addedHeight' into any value you want.
         let addedHeight = font.pointSize * 0.3
         
         return CGSize(width: size.width, height: size.height + addedHeight)
     }
    
}
