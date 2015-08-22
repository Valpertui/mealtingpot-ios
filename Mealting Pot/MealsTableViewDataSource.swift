//
//  MealsDataSource.swift
//  Mealting Pot
//
//  Created by Valentin Pertuisot on 29/06/15.
//  Copyright © 2015 power. All rights reserved.
//

import UIKit
import RealmSwift

class MealsTableViewDataSource : NSObject, UITableViewDataSource
{
    var meals = try! Realm().objects(Meal).filter("date > %@", NSDate())
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return meals.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        guard let cell = tableView.dequeueReusableCellWithIdentifier("mealCell") as! MealTableViewCell? else
        {
            return UITableViewCell(style: .Default, reuseIdentifier: "notMealCell")
        }
        
        let viewModel : MealCellViewModel! = MealCellViewModel(meals[indexPath.row])
        
        cell.mealViewModel = viewModel
        
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
}