//
//  MealModel.swift
//  Mealting Pot
//
//  Created by Valentin Pertuisot on 02/08/15.
//  Copyright © 2015 power. All rights reserved.
//

import Foundation
import RealmSwift

class Meal : Object
{
    dynamic var id : String = ""
    dynamic var title : String = ""
    dynamic var mealDescription : String    = ""
    dynamic var price : Double          = 0.0
    dynamic var category : String = ""
    
    dynamic var host: Person?
    
    dynamic var imageURL : String = ""
    dynamic var date: NSDate = NSDate()
    dynamic var maxGuests : Int         = 1
    dynamic var address : String        = ""
    dynamic var hasLocation : Bool = false
    dynamic var longitude : Double = 0.0
    dynamic var latitude : Double = 0.0
    let guests = List<Person>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    class func dummyMeal() -> Meal
    {
        let meal = Meal()
        
        meal.title = "French breakfast"
        meal.mealDescription = "Come and enjoy a typical french breakfast"
        meal.price = 8.00
        meal.category = "Breakfast"
        meal.imageURL = "https://speakzeasy.files.wordpress.com/2014/10/artistic-french-breakfast-551977.jpg"
        meal.date = NSDate.tomorrow()
        meal.maxGuests = 9
        meal.address = "Woolf College Flat E1"
        meal.hasLocation = true
        meal.latitude = 51.300893
        meal.longitude = 1.0693312
        meal.id = "123" + String(arc4random_uniform(1000))
        return meal
    }
    
}