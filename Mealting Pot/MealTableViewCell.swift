//
//  MealTableViewCell.swift
//  Mealting Pot
//
//  Created by Valentin Pertuisot on 29/06/15.
//  Copyright © 2015 power. All rights reserved.
//

import UIKit
import MapKit
import HCSStarRatingView
import QuartzCore
import PINRemoteImage

@IBDesignable
class MealTableViewCell: UITableViewCell {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var roundCorneredView: UIView!
    
    @IBOutlet weak var mealImageView: UIImageView!
    @IBOutlet weak var mealTitleLabel: UILabel!
    @IBOutlet weak var mealCategoryLabel: UILabel!
    
    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet weak var hostUsernameLabel: UILabel!
    @IBOutlet weak var hostDescriptionLabel: UILabel!
    @IBOutlet weak var hostRatingView: HCSStarRatingView!
    
    @IBOutlet weak var locationView: VPVerticalView!
    @IBOutlet weak var dateView: VPVerticalView!
    @IBOutlet weak var slotsView: VPVerticalView!
    @IBOutlet weak var priceView: VPVerticalView!
    
    var mealViewModel : MealCellViewModel! {
        didSet {
            
            mealImageView.pin_setImageFromURL(mealViewModel.mealImageURL, placeholderImage: UIImage(named: "ProfilePictureDummy"))
            mealTitleLabel.text = mealViewModel.title
            mealCategoryLabel.text = mealViewModel.category
            profilePictureImageView.pin_setImageFromURL(mealViewModel.hostProfilePictureURL, placeholderImage: UIImage(named: "MealCellBackgroundPlaceholder"))
            hostUsernameLabel.text = mealViewModel.hostUsername
            hostDescriptionLabel.text = mealViewModel.hostDescription
            hostRatingView.value = CGFloat(mealViewModel.hostRating)
            locationView.text = mealViewModel.address
            
            let formatter = NSDateFormatter()
            formatter.dateStyle = .ShortStyle
            formatter.timeStyle = .ShortStyle
            dateView.text = formatter.stringFromDate(mealViewModel.date)
            
            slotsView.text = "\(mealViewModel.registeredGuestsCount)/\(mealViewModel.maxGuests)\nfilled seats"
            priceView.text = "£\(mealViewModel.price)"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

        addCardShadow()
    }
    
    func addCardShadow() -> Void
    {
        cardView.layer.shouldRasterize = true
        cardView.layer.rasterizationScale = UIScreen.mainScreen().scale
        
        cardView.layer.shadowRadius = 3
        cardView.layer.shadowOpacity = 0.25
        cardView.layer.shadowOffset = CGSizeMake(1, 1)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
