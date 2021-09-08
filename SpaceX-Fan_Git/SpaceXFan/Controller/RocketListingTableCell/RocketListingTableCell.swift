//
//  RocketListingTableCell.swift
//  SpaceX Fan
//
//  Created by Kavin Soni on 23/06/21.
//

import UIKit
import SDWebImage
import TTTAttributedLabel
//import CoreData

class RocketListingTableCell: UITableViewCell, TTTAttributedLabelDelegate {

    
    @IBOutlet weak var btnFav: UIButton!
    @IBOutlet weak var lblCompany: SpaceXLabel!
    @IBOutlet weak var lblCountry: SpaceXLabel!
    @IBOutlet weak var lblName: SpaceXLabel!
    @IBOutlet weak var lblType: SpaceXLabel!
    @IBOutlet weak var lblLink: TTTAttributedLabel!
    @IBOutlet weak var imgRocket: UIImageView!
    @IBOutlet weak var viewBack: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.lblCompany.textColor = UIColor.Theme.textGrayColor
        self.lblCompany.fontType = .medium
        self.lblCountry.textColor = UIColor.Theme.textGrayColor
        self.lblCountry.fontType = .medium
        self.lblName.textColor = UIColor.black
        self.lblName.fontType = .semibold
        self.lblType.textColor = UIColor.Theme.textGrayColor
        self.lblType.fontType = .medium
        
        self.viewBack.addDropShadow()
        self.lblLink.enabledTextCheckingTypes = NSTextCheckingAllTypes//NSTextCheckingTypeLink; // Automatically detect links when the label text is subsequently changed
        self.lblLink.delegate = self;
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
 
    
    //Setup Cell 
    func setupCell(objModel:RocketInfo) -> Void {
            
        if objModel.company != ""{
//            self.lblCompany.text = "Company: " + objModel.company
            self.setAttributedSTring(label: self.lblCompany, highlightText: "Company: ", normalText: objModel.company, color: UIColor.Theme.textGrayColor)
        }else{
            self.setAttributedSTring(label: self.lblCompany, highlightText: "Company: ", normalText: "N/A", color: UIColor.Theme.textGrayColor)
        }
       
        if objModel.name != ""{
            self.lblName.text = "Name: " + objModel.name
            self.setAttributedSTring(label: self.lblName, highlightText: "Name: ", normalText: objModel.name, color: UIColor.black)

        }else{
            self.setAttributedSTring(label: self.lblName, highlightText: "Name: ", normalText: "N/A", color: UIColor.black)
        }
        
        if objModel.type != ""{
            self.setAttributedSTring(label: self.lblType, highlightText: "Type: ", normalText: objModel.type, color: UIColor.Theme.textGrayColor)

        }else{
            self.setAttributedSTring(label: self.lblType, highlightText: "Type: ", normalText: "N/A", color: UIColor.Theme.textGrayColor)
        }
        
        if objModel.wikipedia != ""{
            
            self.lblLink.text = "Wikipedia: " + objModel.wikipedia
                        
        }else{
            self.lblLink.text = "Wikipedia: N/A"
        }
        
        
        if objModel.isFavourite == true{
            self.btnFav.setImage(UIImage.init(named: "favorite_ic"), for: .normal)
        }else{
            self.btnFav.setImage(UIImage.init(named: "Favorite"), for: .normal)
        }
        
        
        if objModel.country != ""{
            self.setAttributedSTring(label: self.lblCountry, highlightText: "Country: ", normalText: objModel.country, color: UIColor.Theme.textGrayColor)

//            self.lblCountry.text = "Country: " + objModel.country
        }else{
            self.setAttributedSTring(label: self.lblCountry, highlightText: "Country: ", normalText: "N/A", color: UIColor.Theme.textGrayColor)

        }
        
        
        if objModel.flickrImages.count > 0 {
            if let firstImage = objModel.flickrImages[0] as? String{
                self.imgRocket.sd_setImage(with: URL(string: firstImage), completed:nil)
            }
        }else{
            self.imgRocket.image = UIImage.init(named: "spacecraft.jpeg")
        }
    }
    
    //Set upcoming cell
    func setupUpcomingCell(objModel:UpcomingLaunches) -> Void {
            
       
        if objModel.name != ""{
            self.lblName.text = "Name: " + objModel.name
            self.setAttributedSTring(label: self.lblName, highlightText: "Name: ", normalText: objModel.name, color: UIColor.black)

        }else{
            self.setAttributedSTring(label: self.lblName, highlightText: "Name: ", normalText: "N/A", color: UIColor.black)
        }
        
        self.imgRocket.image = UIImage.init(named: "spacecraft.jpeg")
        self.setAttributedSTring(label: self.lblCompany, highlightText: "Company: ", normalText: "N/A", color: UIColor.Theme.textGrayColor)
        self.setAttributedSTring(label: self.lblType, highlightText: "Type: ", normalText: "N/A", color: UIColor.Theme.textGrayColor)
        self.lblLink.text = "Wikipedia: N/A"
        self.setAttributedSTring(label: self.lblCountry, highlightText: "Country: ", normalText: "N/A", color: UIColor.Theme.textGrayColor)

    }
    
    
    func attributedLabel(_ label: TTTAttributedLabel!, didSelectLinkWith url: URL!) {
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    //Set attribute string
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
