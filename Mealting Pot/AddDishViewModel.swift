//
//  AddDishViewModel.swift
//  Mealting Pot
//
//  Created by Valentin Pertuisot on 25/08/15.
//  Copyright © 2015 power. All rights reserved.
//

import Foundation

class AddDishViewModel {
    
    var name = ""
    var dishDescription = ""
    var type = ""
    var saved = false
    
    func getDish() -> Dish {
        let dish = Dish()
        dish.name = name
        dish.dishDescription = dishDescription
        dish.type = type
        
        return dish
    }
}