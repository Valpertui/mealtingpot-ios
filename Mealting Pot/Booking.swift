//
//  Booking.swift
//  Mealting Pot
//
//  Created by Valentin Pertuisot on 26/08/15.
//  Copyright © 2015 power. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

class Booking : Object
{
    dynamic var id : String = ""
    dynamic var mealId : String = ""
    dynamic var userId : String = ""
    dynamic var user: Person?
    dynamic var seats = 1
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(jsonDict: JSON) {
        self.init()
        if let bookingId = jsonDict["id"].string {
            id = bookingId
        }
        if let mealId = jsonDict["mealId"].string {
            self.mealId = mealId
        }
        if let userId = jsonDict["userId"].string {
            self.userId = userId
        }
        if let seats = jsonDict["seats"].int {
            self.seats = seats
        }
    }
}
