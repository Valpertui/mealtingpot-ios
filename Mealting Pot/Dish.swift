//
//  Dish.swift
//  Mealting Pot
//
//  Created by Valentin Pertuisot on 19/08/15.
//  Copyright © 2015 power. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

class Dish : Object
{
    //dynamic var id : String = ""
    dynamic var name : String = ""
    dynamic var dishDescription : String = ""
    dynamic var cuisine : String = ""
    dynamic var type : String = ""
    //dynamic var meal : Meal?
    
//    override static func primaryKey() -> String? {
//        return "id"
//    }
    
    convenience init(jsonDict: JSON) {
        self.init()
//        if let dishId = jsonDict["id"].string {
//            id = mealId
//        }
        if let dishName = jsonDict["name"].string {
            name = dishName
        }
        if let description = jsonDict["description"].string {
            dishDescription = description
        }
        if let dishType = jsonDict["type"].string {
            type = dishType
        }
    }

}