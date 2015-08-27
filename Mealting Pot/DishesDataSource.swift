//
//  DishesDataSource.swift
//  Mealting Pot
//
//  Created by Valentin Pertuisot on 26/08/15.
//  Copyright © 2015 power. All rights reserved.
//

import UIKit

class DishesDataSource : NSObject, UITableViewDataSource {
    
    var dishes : [Dish] = []
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        switch section {
        case 0:
            return dishes.count
        default:
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCellWithIdentifier("dishCell") else
            {
                return UITableViewCell(style: .Default, reuseIdentifier: "notDishCell")
            }
            cell.textLabel!.text = dishes[indexPath.row].name
            cell.detailTextLabel!.text = dishes[indexPath.row].type
            return cell
        default:
            return UITableViewCell(style: .Default, reuseIdentifier: "unknownCell")
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
}