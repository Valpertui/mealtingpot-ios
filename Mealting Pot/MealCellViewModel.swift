//
//  MealViewModel.swift
//  Mealting Pot
//
//  Created by Valentin Pertuisot on 02/08/15.
//  Copyright © 2015 power. All rights reserved.
//

import Foundation
import RealmSwift
import Alamofire
import SwiftyJSON

class MealCellViewModel
{
    let id : String
    let title : String
    let mealDescription : String
    let category : String
    let mealImageURL : NSURL?
    let price : Double
    let address : String
    let date : NSDate
    let registeredGuestsCount : Int
    let maxGuests : Int
    let latitude : Double
    let longitude : Double
    
    var hostProfilePictureURL : NSURL?
    var hostUsername : String = ""
    var hostDescription : String = ""
    var hostRating : Double = 0.0

    
    init(_ meal: Meal)
    {
        id = meal.id
        title = meal.title
        mealDescription = meal.mealDescription
        category = meal.category
        mealImageURL = NSURL(string:meal.imageURL)
        price = meal.price
        address = meal.address
        date = meal.date
        registeredGuestsCount = try! Realm().objects(Booking).filter("mealId == %@", meal.id).sum("seats")
        maxGuests = meal.maxGuests
        latitude = meal.latitude
        longitude = meal.longitude
        
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
    
    func getPicture(completion : (success : Bool, imageURL : NSURL?) -> Void) -> Void {
        Alamofire.request(Router.GetPicturesForMeal(mealId: id))
            .validate()
            .responseJSON { (_, _, result) -> Void in
                switch result {
                case .Success(let value):
                    let jsonPictures = JSON(value)
                    if let picURL = jsonPictures[0]["url"].string {
                        completion(success: true, imageURL: NSURL(string:picURL))
                    }
                case.Failure:
                    if let error = result.error as? NSError {
                        print(error.localizedDescription)
                    }
                    completion(success: false, imageURL: nil)
                }
        }
    }
}
