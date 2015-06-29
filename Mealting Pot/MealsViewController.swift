//
//  mealsViewController.swift
//  Mealting Pot
//
//  Created by Valentin Pertuisot on 28/06/15.
//  Copyright © 2015 power. All rights reserved.
//

import Foundation
import UIKit

class MealsViewController : UIViewController, UITableViewDelegate
{
    @IBOutlet weak var tableView: UITableView!
    let dataSource : UITableViewDataSource = MealsDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = dataSource
        tableView.registerNib(UINib(nibName: "MealTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "mealCell")
        
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if self.traitCollection.horizontalSizeClass == .Regular && self.traitCollection.verticalSizeClass == .Regular
        {
            return 328
        }
        return 204
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if self.traitCollection.horizontalSizeClass == .Regular && self.traitCollection.verticalSizeClass == .Regular
        {
            return 328
        }
        return 204
    }
}