//
//  NewMealViewModel.swift
//  Mealting Pot
//
//  Created by Valentin Pertuisot on 25/08/15.
//  Copyright © 2015 power. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import SVProgressHUD

class NewMealViewModel {
    
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
    var tags = []
    var dishes : [Dish] = []
    var chosenImage : UIImage?
    
    func postMeal() -> Void {
        var params = [String:AnyObject]()
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'SSS'Z'"
        let dishesRep = dishes.map { dish in
            return ["name": dish.name, "description" : dish.dishDescription, "type" : dish.type]
        }
        params = ["title": title, "description": description, "format": format, "cuisine": cuisine, "price": price, "date": dateFormatter.stringFromDate(date), "seats": seatsNumber, "tags": tags, "dishes": dishesRep]
        if locationProvided == true
        {
            params["location"] = ["latitude": latitude, "longitude": longitude]
        }
        print(params)
        Alamofire.request(Router.PostMeal(params))
            .validate()
            .responseJSON { (_, _, result) -> Void in
                switch result {
                case .Success(let value):
                    let json = JSON(value)
                    let meal = Meal(jsonDict: json)
                    guard let imageToUpload = self.chosenImage else {
                        return
                    }
                    Alamofire.request(Router.PostPictureForMeal(mealId: meal.id))
                        .validate()
                        .responseJSON(completionHandler: {(_, _, result) -> Void in
                            switch result {
                            case .Success(let value):
                                let jsonResponse = JSON(value)
                                if let uploadURL = jsonResponse["aws"]["signed_request"].string {
                                    Alamofire.upload(.POST, uploadURL, data: UIImageJPEGRepresentation(imageToUpload, 1.0)!)
                                }
                                
                            case .Failure:
                                if let error = result.error as? NSError {
                                    SVProgressHUD.showErrorWithStatus(error.localizedDescription)
                                }
                            }
                        })
                    
                case .Failure:
                    if let error = result.error as? NSError {
                        SVProgressHUD.showErrorWithStatus(error.localizedDescription)
                    }
                }
            }
        }
}