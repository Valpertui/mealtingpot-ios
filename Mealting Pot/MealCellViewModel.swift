//
//  MealViewModel.swift
//  Mealting Pot
//
//  Created by Valentin Pertuisot on 02/08/15.
//  Copyright © 2015 power. All rights reserved.
//

import Foundation

class MealCellViewModel
{
    let title : String
    let mealDescription : String
    let category : String
    let mealImageURL : NSURL?
    let price : Double
    let address : String
    let date : NSDate
    let registeredGuestsCount : Int
    let maxGuests : Int
    
    var hostProfilePictureURL : NSURL?
    var hostUsername : String = ""
    var hostDescription : String = ""
    var hostRating : Double = 0.0

    
    init(_ meal: Meal)
    {
        title = meal.title
        mealDescription = meal.mealDescription
        category = meal.category
        mealImageURL = NSURL(string:meal.imageURL)
        price = meal.price
        address = meal.address
        date = meal.date
        registeredGuestsCount = meal.guests.count
        maxGuests = meal.maxGuests
        
        
        guard let host = meal.host else {
            return
        }
        
        hostProfilePictureURL = NSURL(string:host.imageURL)
        hostUsername = host.name
        hostDescription = host.userDescription
//        hostRating = host.reviews.map{$0.rating / 2.0}.reduce(0.0) {
//            $0 + $1/Double(host.reviews.count)
//        }
        hostRating = host.rating
    }
}
