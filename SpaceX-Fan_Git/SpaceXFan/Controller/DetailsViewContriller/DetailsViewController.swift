//
//  DetailsViewController.swift
//  SpaceX Fan
//
//  Created by Kavin Soni on 27/06/21.
//

import UIKit
import TTTAttributedLabel

@available(iOS 13.0, *)
class DetailsViewController: BaseViewController ,TTTAttributedLabelDelegate{

    //VARIABLES
    var rocketModel:RocketInfo?
    var upcomingLaunchesModel:UpcomingLaunches?

    var displayImage:Int = 0
    var isFromUpcoming:Bool = false

    
    //OUTLETS
    
    @IBOutlet weak var pageViewController: UIPageControl!
    @IBOutlet weak var imgSlider: UIImageView!
    @IBOutlet weak var lblName: SpaceXLabel!
    @IBOutlet weak var lblDetails: SpaceXLabel!
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var lblType: SpaceXLabel!
    @IBOutlet weak var lblCountry: SpaceXLabel!
    @IBOutlet weak var lblCompany: SpaceXLabel!
    @IBOutlet weak var lblWikipidia: TTTAttributedLabel!
    @IBOutlet weak var lblFirstFlight: SpaceXLabel!
    @IBOutlet weak var lblId: SpaceXLabel!
    @IBOutlet weak var lblCostPerLunch: SpaceXLabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Setup UI
        self.setupUI()
        
        //Setup Data
        self.setData()
    }
    
    //MARK:Setup UI
    func setupUI() -> Void {
        
        //set title in navigation
        self.setTitleNavigationController(text: "Rocket Details")
        
        //set backbutton image
        self.setLeftBarButton(img: UIImage.init(named: "back-white"))
        
        //add shadow and corner radius to background
        self.viewBackground.addDropShadow()
        self.viewBackground.layer.cornerRadius = 5
        self.viewBackground.clipsToBounds = true
        
        
        //set page controller

        self.pageViewController.numberOfPages = self.rocketModel?.flickrImages.count ?? 0
        self.pageViewController.currentPage = 0
        self.pageViewController.tintColor = UIColor.Theme.themeColor
        self.pageViewController.backgroundColor = UIColor.clear
        self.pageViewController.currentPageIndicatorTintColor = UIColor.Theme.themeColor
        self.imgSlider.isUserInteractionEnabled = true
        
        
        // Add swipe gesture to change Image on swipe
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
           swipeRight.direction = .right
           self.imgSlider.addGestureRecognizer(swipeRight)

           let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
            swipeLeft.direction = .left
           self.imgSlider.addGestureRecognizer(swipeLeft)
        
        self.displayImage = 0

        
        //Set wikipidia link touchable
        self.lblWikipidia.enabledTextCheckingTypes = NSTextCheckingAllTypes//NSTextCheckingTypeLink; // Automatically detect links when the label text is subsequently changed
        self.lblWikipidia.delegate = self;

        
        
    }
    //MARK: Set Data
    func setData() -> Void {

        if self.rocketModel?.company != ""{
            self.setAttributedSTring(label: self.lblCompany, highlightText: "Company: ", normalText: self.rocketModel?.company ?? "", color: UIColor.Theme.textGrayColor)
        }else{
            self.setAttributedSTring(label: self.lblCompany, highlightText: "Company: ", normalText: "N/A", color: UIColor.Theme.textGrayColor)
        }
       
        if self.rocketModel?.name != ""{
            self.lblName.text = "Name: " + self.rocketModel!.name
            self.setAttributedSTring(label: self.lblName, highlightText: "Name: ", normalText: self.rocketModel?.name ?? "", color: UIColor.black)

        }else{
            self.setAttributedSTring(label: self.lblName, highlightText: "Name: ", normalText: "N/A", color: UIColor.black)
        }
        
        if self.rocketModel?.type != ""{
            self.setAttributedSTring(label: self.lblType, highlightText: "Type: ", normalText: self.rocketModel?.type ?? "", color: UIColor.Theme.textGrayColor)

        }else{
            self.setAttributedSTring(label: self.lblType, highlightText: "Type: ", normalText: "N/A", color: UIColor.Theme.textGrayColor)
        }
        
        if self.rocketModel?.wikipedia != ""{
            
            self.lblWikipidia.text = "Wikipedia: " + self.rocketModel!.wikipedia
                        
        }else{
            self.lblWikipidia.text = "Wikipedia: N/A"
        }
        
        if self.rocketModel?.country != ""{
            self.setAttributedSTring(label: self.lblCountry, highlightText: "Country: ", normalText: self.rocketModel?.country ?? "", color: UIColor.Theme.textGrayColor)
        }else{
            self.setAttributedSTring(label: self.lblCountry, highlightText: "Country: ", normalText: "N/A", color: UIColor.Theme.textGrayColor)
        }
        
        if self.rocketModel?.id != ""{
            self.setAttributedSTring(label: self.lblId, highlightText: "ID: ", normalText: self.rocketModel?.id ?? "", color: UIColor.Theme.textGrayColor)
        }else{
            self.setAttributedSTring(label: self.lblId, highlightText: "ID: ", normalText: "N/A", color: UIColor.Theme.textGrayColor)
        }
        
        if self.rocketModel?.costPerLaunch != 0{
            self.setAttributedSTring(label: self.lblCostPerLunch, highlightText: "Cost per launch: ", normalText: "\(self.rocketModel?.costPerLaunch ?? 0)", color: UIColor.Theme.textGrayColor)
        }else{
            self.setAttributedSTring(label: self.lblCostPerLunch, highlightText: "Cost per launch: ", normalText: "N/A", color: UIColor.Theme.textGrayColor)
        }
        
        if self.rocketModel?.firstFlight != ""{
            self.setAttributedSTring(label: self.lblFirstFlight, highlightText: "First Flight: ", normalText: self.rocketModel?.firstFlight ?? "", color: UIColor.Theme.textGrayColor)
        }else{
            self.setAttributedSTring(label: self.lblFirstFlight, highlightText: "First Flight: ", normalText: "N/A", color: UIColor.Theme.textGrayColor)
        }
        
        
        
        self.lblDetails.text = self.rocketModel?.rocketInfoDescription
        
        
        if self.rocketModel?.flickrImages.count ?? 0 > 0 {
            if let firstImage = self.rocketModel?.flickrImages[0]{
                self.imgSlider.sd_setImage(with: URL(string: firstImage), completed:nil)
            }
        }
    }
    
    
    //MARK: Swipe gesture code
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {

        if let swipeGesture = gesture as? UISwipeGestureRecognizer {

            switch swipeGesture.direction {
            case .right:

                if 0 < self.displayImage {
                    self.displayImage = self.displayImage - 1
                    self.pageViewController.currentPage = self.displayImage
                    let image = self.rocketModel?.flickrImages[self.displayImage]
                    if image != ""{
                        self.imgSlider.sd_setImage(with: URL(string: image!), completed:nil)
                    }
                }
            
            case .left:
                if self.displayImage < self.rocketModel!.flickrImages.count - 1{
                    self.displayImage = self.displayImage + 1
                    
                    self.pageViewController.currentPage = self.displayImage
                    let image = self.rocketModel?.flickrImages[self.displayImage]
                    if image != ""{
                        self.imgSlider.sd_setImage(with: URL(string: image!), completed:nil)
                    }                    
                }
            default:
                break
            }
        }
    }
    

    
    //MARK: Attributed Label For URL clickble
    
    func attributedLabel(_ label: TTTAttributedLabel!, didSelectLinkWith url: URL!) {
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    func setAttributedSTring(label:SpaceXLabel , highlightText:String , normalText:String , color:UIColor) -> Void {
        
        
        let firstAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor: color,NSAttributedString.Key.font:UIFont.font_bold(label.font.pointSize)]
        
        // NSAttributedString.Key.kern: 10
        let secondAttributes = [NSAttributedString.Key.foregroundColor: color,NSAttributedString.Key.font:UIFont.font_medium(label.font.pointSize)]

        let firstString = NSMutableAttributedString(string: highlightText, attributes: firstAttributes)
        let secondString = NSAttributedString(string: normalText, attributes: secondAttributes)
        firstString.append(secondString)
        label.attributedText =  firstString
    }
    
    

}
