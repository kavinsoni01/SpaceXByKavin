//
//  SpaceXTextField.swift
//  SpaceX Fan
//
//  Created by Kavin Soni on 27/06/21.
//

import UIKit

enum TextFieldUIType {
    case normal
}

enum TextFieldType:Int{
    case password
    case email
    case none
}


class SpaceXTextField: UITextField,UITextFieldDelegate{
    
    var selectedIcon:UIImage?
    var maximumLimit = 100
    let borderLayer = CAShapeLayer()
    
    var padding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    
    var textFieldType:TextFieldType = .none{
        didSet{
            commonInit()
        }
    }
    var textFieldUIType:TextFieldUIType = .normal{
        didSet{
            commonInit()
            
        }
    }
    
    // MARK: Config Variable
    
    
  
    
    // MARK: Validation Message
    public var strEmptyValidationMessage: String = ""
    public var strValidationMessage: String = ""
    
    // MARK: Operation On Select
    public var shouldPreventAllActions: Bool = false
    public var canCut: Bool = false
    public var canCopy: Bool = false
    public var canPaste: Bool = false
    public var canSelect: Bool = true
    public var canSelectAll: Bool = true
    public var needToLayoutSubviews: Bool = true
     
    /// User this block user need to chack for Min-Max length ans input
    public var textFieldShouldChangeCharacterHandler: ((_ textField: UITextField, _ range: NSRange, _ str: String) -> Bool)?
    
    /// Use for get text change event


    
    // MARK: Padding for leftView RightView
    public var leftViewPadding: CGFloat? = 0 {
        didSet {
            if let lPadding = self.leftViewPadding, lPadding > 0 {
                var paddingView: UIView? = self.leftView
                if self.leftView == nil {
                    paddingView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: lPadding, height: self.frame.height))
                }
                paddingView?.frame = CGRect.init(x: 0, y: 0, width: lPadding, height: self.frame.height)
                self.leftView = paddingView
                self.leftViewMode = UITextField.ViewMode.always
            } else {
                self.leftView = nil
                self.leftViewMode = UITextField.ViewMode.never
            }
        }
    }
    
    var leftIcon: UIImage? = nil {
        didSet {
            guard let img = self.leftIcon else {
                self.leftView = nil
                return
            }
            let viewSize = CGSize.init(width: img.size.width + 10.0, height: img.size.height + 10.0)
            let padding: CGFloat = 8

            let imageView = UIImageView(frame: CGRect(x: padding, y: 0, width: viewSize.width, height: viewSize.height))
            imageView.contentMode = .center
           
            
            let outerView = UIView(frame: CGRect(x: 0, y: 0, width: padding * 2 + viewSize.width, height: viewSize.height))
            imageView.image = img
            imageView.setImageColor(color: UIColor.Theme.textGrayColor)
            outerView.addSubview(imageView)
            self.leftView = outerView // Or rightView = outerView
            self.leftViewMode = .always
            
        }
    }
    
    var rightIcon: UIImage? = nil {
        didSet {
            guard let img = self.rightIcon else {
                self.rightView = nil
                return
            }
            
            
            let viewSize = CGSize.init(width: img.size.width + 5, height: img.size.height + 10.0)
            let padding: CGFloat = 0

            let imageView = UIImageView(frame: CGRect(x: padding, y: 0, width: viewSize.width, height: viewSize.height))
            imageView.contentMode = .center
           
            let outerView = UIView(frame: CGRect(x: 0, y: 0, width: padding * 2 + viewSize.width, height: viewSize.height))
           
            imageView.image = img
            outerView.addSubview(imageView)
            self.rightView = outerView // Or rightView = outerView
            self.rightViewMode = .always
            
//                let viewSize = CGSize.init(width: img.size.width + 10.0, height: img.size.height + 10.0)
//                let imgView: UIImageView = UIImageView.init(frame: CGRect(origin: CGPoint.zero, size: viewSize))
//                imgView.contentMode = .center
//                imgView.image = img
//                self.rightView = imgView
//                self.rightViewMode = .always
        }
    }
    
    public var rightViewPadding: CGFloat? = 0 {
        didSet {
            if let lPadding = self.rightViewPadding, lPadding > 0 {
                var paddingView: UIView? = self.rightView
                if self.rightView == nil {
                    paddingView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: lPadding, height: self.frame.height))
                }
                paddingView?.frame = CGRect.init(x: 0, y: 0, width: lPadding, height: self.frame.height)
                self.rightView = paddingView
                self.rightViewMode = UITextField.ViewMode.always
            } else {
                self.rightView = nil
                self.rightViewMode = UITextField.ViewMode.never
            }
        }
    }
    
    
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        initialize()
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }


    
    private func commonInit()
    {
        self.delegate = self
        
        let selfValue = self.font?.pointSize
        self.font = UIFont.font_medium(selfValue ?? 15)
//            padding = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0);
//            self.textFieldTextchangeHandler? (self)

        switch textFieldUIType {
        
        case .normal:
            
            self.textColor = UIColor.black
            self.placeHolderColor = UIColor.Theme.textGrayColor
            self.backgroundColor = UIColor.clear
            
            self.layer.borderWidth = 1.0
            self.layer.borderColor = UIColor.Theme.themeColor.cgColor
            self.layer.cornerRadius = 5.0
            self.clipsToBounds = true
           
            padding = UIEdgeInsets(top: 0, left: CGFloat(Double(leftView?.frame.width ?? 0)) , bottom: 0, right: CGFloat(Double(rightView?.frame.width ?? 0)))

            
            
//            if (leftViewPadding != nil) {
//                padding = UIEdgeInsets(top: 0, left: self.leftViewPadding ?? 0 , bottom: 0, right: CGFloat(Double(rightView?.frame.width ?? 0)))
//
//            }else{
//                padding = UIEdgeInsets(top: 0, left: CGFloat(Double(leftView?.frame.width ?? 0)) , bottom: 0, right: CGFloat(Double(rightView?.frame.width ?? 0)))
//
//            }
            
       
//        @unknown default:
//            break
        }
        switch textFieldType {
        
        case .password:
            self.keyboardType = .default
            self.isSecureTextEntry = true
            
        case .none :
            
            self.isSecureTextEntry = false
            self.keyboardType = .default
            break
        
            
        case .email :
            
            self.isSecureTextEntry = false
            self.keyboardType = .emailAddress
            break

            
//        @unknown default:
//            //                self.autocapitalizationType = .sentences
//            //                self.isSecureTextEntry = false
//            break
        }
        
    }
    // MARK: Initialization
    func initialize() {
        var deltaSize : CGFloat = 0
        
        switch (UIDevice.deviceType) {
        case .iPhone4_4s,
             .iPhone5_5s :
            deltaSize = -1;
        case .iPhone6_6s :
            deltaSize = 0;
        case .iPhone6p_6ps :
            deltaSize = 0;
        case .iPhonex_xs,.iPhonexr_xsmax:
            deltaSize = 1;
        case .iPad :
            deltaSize = 9;
        }
        
        let selfValue = self.font?.pointSize
        deltaSize = CGFloat(selfValue ?? 13) + deltaSize;
        
            self.font = UIFont.font_medium(deltaSize)
        
      
    }
    

    
    
    
  
}
extension UITextField{
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
}


// MARK: For Provide Configuratiuon
extension SpaceXTextField {
    /// For textField State Option
    public enum TextFieldState: Int {
        case normal
        case edittable
    }
}
