//
//  ReviewModel.swift
//  Mealting Pot
//
//  Created by Valentin Pertuisot on 14/08/15.
//  Copyright © 2015 power. All rights reserved.
//

import Foundation
import RealmSwift

class Review : Object
{
    dynamic var id : String = ""
    dynamic var rating : Double = 0.0
    dynamic var title : String = ""
    dynamic var reviewDescription : String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}