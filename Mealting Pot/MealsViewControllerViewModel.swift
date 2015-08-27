//
//  MealsViewControllerViewModel.swift
//  Mealting Pot
//
//  Created by Valentin Pertuisot on 24/08/15.
//  Copyright © 2015 power. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import RealmSwift

class MealsViewControllerViewModel {
 
    let dataSource = MealsTableViewDataSource()
    
    func refreshMeals(completion : (success: Bool) -> Void) -> Void {
        Alamofire.request(Router.GetMeals([:]))
            .validate()
            .responseJSON { (_, _, result) -> Void in
                switch result {
                case .Success(let value):
                    let json = JSON(value)
                    self.updateDBFromResponse(json)
                    completion(success: true)
                case .Failure:
                    if let error = result.error as? NSError {
                        print(error)
                    }
                    completion(success: false)
                }
            }
    }
    
    func updateDBFromResponse(json: JSON) -> Void {
        _ = json.arrayValue.map({ mealJson in
            
            let realm = try! Realm()
            
            let creatorJson = mealJson["user"]
            let creator = Person(jsonDict: creatorJson)
            creator.save()
            
            let meal = Meal(jsonDict: mealJson)
            meal.host = creator
            meal.save()
            
            var dishArray : [Dish] = []
           _ = mealJson["dishes"].arrayValue.map({ dishJson in
                let dish = Dish(jsonDict: dishJson)
                dishArray.append(dish)
            })
        
            realm.write {
                meal.dishes.removeAll()
                _ = dishArray.map { dish in
                    meal.dishes.append(dish)
                }
                
            }
            let bookings = realm.objects(Booking).filter("mealId == %@", meal.id)
            realm.write {
                realm.delete(bookings)
            }
            _ = mealJson["bookings"].arrayValue.map({ bookingJson in
                let booking = Booking(jsonDict: bookingJson)
                let userJson = bookingJson["user"]
                if userJson != nil {
                    let user = Person(jsonDict: userJson)
                    booking.user = user
                }
                booking.save()
            })
        })
    }
}