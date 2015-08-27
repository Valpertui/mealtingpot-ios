//
//  BookingsDataSource.swift
//  Mealting Pot
//
//  Created by Valentin Pertuisot on 26/08/15.
//  Copyright © 2015 power. All rights reserved.
//

import UIKit
import RealmSwift

class BookingsDataSource : NSObject, UITableViewDataSource
{
    var meals : Results<Meal> = BookingsDataSource.getBookedMeals()
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return meals.count
    }
    
    func updateBookedMeals() -> Void {
        meals = BookingsDataSource.getBookedMeals()
    }
    
    class func getBookedMeals() -> Results<Meal> {
        var userId = ""
        if let tmpId = ConfigurationManager.userId {
            userId = tmpId
        }
        let realm = try! Realm()
        let bookings = realm.objects(Booking).filter("userId == %@", userId)
        return realm.objects(Meal).filter("id IN %@", bookings.map {$0.mealId}).sorted("date", ascending: true)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        guard let cell = tableView.dequeueReusableCellWithIdentifier("mealCell") as! MealTableViewCell? else
        {
            return UITableViewCell(style: .Default, reuseIdentifier: "notMealCell")
        }
        
        let viewModel : MealCellViewModel! = MealCellViewModel(meals[indexPath.row])
        
        cell.mealViewModel = viewModel
        cell.mealViewModel.getPicture{ (success, imageURL) -> Void in
            if success == true && imageURL != nil {
                // cell.mealImageView.pin_setImageFromURL(imageURL)
            }
        }
        
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
}
