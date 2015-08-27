//
//  MealViewModel.swift
//  Mealting Pot
//
//  Created by Valentin Pertuisot on 26/08/15.
//  Copyright © 2015 power. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift
import SVProgressHUD
import SwiftyJSON

class MealViewModel {
    var id = ""
    var title = ""
    var description = ""
    var latitude = 0.0
    var longitude = 0.0
    var locationProvided = false
    var format = ""
    var cuisine = ""
    var price = 0.0
    var date = NSDate()
    var seatsNumber = 0
    var reservedSeats = 0
    var tags = []
    var dishes : [Dish] = []
    var mealPictureURL : NSURL?
    
    init(meal: Meal) {
        id = meal.id
        title = meal.title
        description = meal.mealDescription
        latitude = meal.latitude
        longitude = meal.longitude
        locationProvided = true
        format = meal.format
        cuisine = meal.category
        price = meal.price
        date = meal.date
        seatsNumber = meal.maxGuests
        reservedSeats = try! Realm().objects(Booking).filter("mealId == %@", meal.id).sum("seats")
        dishes = meal.dishes.map { $0 }
    }
    
    func bookMeal() -> Void {
        Alamofire.request(Router.BookMeal(mealId: id, seats: 1))
            .validate()
            .responseJSON { (_, _, result) -> Void in
                switch result {
                case .Success(let value):
                    let jsonBooking = JSON(value)
                    let booking = Booking(jsonDict: jsonBooking)
                    booking.save()
                    return
                case .Failure:
                    if let error = result.error as? NSError {
                        SVProgressHUD.showErrorWithStatus(error.localizedDescription)
                    }
                }
        }
    }
}