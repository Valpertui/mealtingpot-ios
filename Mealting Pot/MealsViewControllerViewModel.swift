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

class MealsViewControllerViewModel {
 
    let dataSource = MealsTableViewDataSource()
    
    func refreshMeals() -> Void {
        Alamofire.request(Router.GetMeals([:]))
            .validate()
            .responseJSON { (_, _, result) -> Void in
                switch result {
                case .Success(let value):
                    let json = JSON(value)
                    self.updateDBFromResponse(json)
                    print(json)
                case .Failure:
                    if let error = result.error as? NSError {
                        print(error)
                    }
                }
            }
    }
    
    func updateDBFromResponse(json: JSON) -> Void {
        
    }
}