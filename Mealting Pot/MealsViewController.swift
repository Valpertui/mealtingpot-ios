//
//  mealsViewController.swift
//  Mealting Pot
//
//  Created by Valentin Pertuisot on 28/06/15.
//  Copyright © 2015 power. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class MealsViewController : UIViewController, UITableViewDelegate
{
    @IBOutlet weak var tableView: UITableView!
    let dataSource : UITableViewDataSource = MealsTableViewDataSource()
    var realmToken : NotificationToken!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = dataSource
        tableView.registerNib(UINib(nibName: "MealTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "mealCell")
        tableView.separatorStyle = .None
        realmToken = try! Realm().addNotificationBlock { (notification, realm) -> Void in
                self.tableView.reloadData()
        }
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
       return 321
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
       return 321
    }
}