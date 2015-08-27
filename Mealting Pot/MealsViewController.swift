//
//  mealsViewController.swift
//  Mealting Pot
//
//  Created by Valentin Pertuisot on 28/06/15.
//  Copyright © 2015 power. All rights reserved.
//

import UIKit
import RealmSwift
import DZNEmptyDataSet

class MealsViewController : UIViewController, UITableViewDelegate, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate
{
    @IBOutlet weak var tableView: UITableView!
    let viewModel : MealsViewControllerViewModel = MealsViewControllerViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = viewModel.dataSource
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        tableView.registerNib(UINib(nibName: "MealTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "mealCell")
        tableView.separatorStyle = .None
        self.tableView.reloadData()
    }
    
    override func viewWillAppear(animated: Bool) {
        viewModel.refreshMeals { (success : Bool) -> Void in
            self.tableView.reloadData()
        }
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
       return 321
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
       return 321
    }
    
    func titleForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string: "No meals yet 😞", attributes: [NSForegroundColorAttributeName:UIColor.mainColor(), NSFontAttributeName:UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)])
    }
    
    func descriptionForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string: "Nobody is hosting a meal around you, but you can be the first !", attributes: [NSForegroundColorAttributeName:UIColor.mainColor(), NSFontAttributeName:UIFont.preferredFontForTextStyle(UIFontTextStyleBody)])
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("showMealVC", sender: self.viewModel.dataSource.meals[indexPath.row] )
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        guard let identifier = segue.identifier else {
            return
        }
        switch identifier {
            case "showMealVC":
            let destVC = segue.destinationViewController as! MealViewController
            if let meal = sender as? Meal {
                destVC.viewModel = MealViewModel(meal: meal)
            }
        default:
            break
        }
    }
}