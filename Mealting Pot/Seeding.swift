//
//  File.swift
//  Mealting Pot
//
//  Created by Valentin Pertuisot on 19/08/15.
//  Copyright © 2015 power. All rights reserved.
//

import Foundation
import RealmSwift
import Timepiece

extension Realm
{
    func seed() -> Void {
        
        let owner = Person.dummyPerson()
        
        self.write { () -> Void in
            self.add(owner)
        }
        
        let meal1 = Meal.dummyMeal()
        meal1.host = owner
        
        let meal2 = Meal.dummyMeal()
        meal2.host = owner
        meal2.title = "Chinese cuisine"
        meal2.mealDescription = "Discover tradional chinese duck"
        
        self.write { () -> Void in
            self.add(meal1)
            self.add(meal2)
        }
    }
}