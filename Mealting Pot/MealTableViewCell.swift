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

@IBDesignable
class MealTableViewCell: UITableViewCell {

    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var mealImageView: UIImageView!
    @IBOutlet weak var mealTitle: UILabel!
    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet weak var hostUsernameLabel: UILabel!
    @IBOutlet weak var hostRatingView: HCSStarRatingView!
    @IBOutlet weak var mealPriceLabel: UILabel!
    @IBOutlet weak var mealLocationPreviewMap: MKMapView?
    @IBOutlet weak var mealCategoryLabel: UILabel!
    @IBOutlet weak var mealDateLabel: UILabel!
    @IBOutlet weak var mealLocationDescriptionLabel: UILabel!
    @IBOutlet weak var mealTypeLabel: UILabel!
    @IBOutlet weak var mealRemainingSlotsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addCardShadow()
        // Initialization code
    }

    func addCardShadow() -> Void
    {
        self.cardView.layer.shadowRadius = 3
        self.cardView.layer.shadowOpacity = 0.15
        self.cardView.layer.shadowOffset = CGSizeMake(1, 1)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
