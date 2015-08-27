//
//  BookingsViewController.swift
//  Mealting Pot
//
//  Created by Valentin Pertuisot on 20/08/15.
//  Copyright © 2015 power. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class BookingsViewController: UIViewController, UITableViewDelegate, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {

    @IBOutlet weak var bookingsTableView: UITableView!
    
    let viewModel : BookingsViewControllerViewModel = BookingsViewControllerViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bookingsTableView.dataSource = viewModel.dataSource
        bookingsTableView.emptyDataSetSource = self
        bookingsTableView.emptyDataSetDelegate = self
        bookingsTableView.registerNib(UINib(nibName: "MealTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "mealCell")
        bookingsTableView.separatorStyle = .None
        self.bookingsTableView.reloadData()
    }

    override func viewWillAppear(animated: Bool) {
        self.viewModel.dataSource.updateBookedMeals()
        viewModel.refreshBookings{ (success : Bool) -> Void in
            self.bookingsTableView.reloadData()
        }
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 321
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 321
    }
    
    func titleForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string: "You have not booked anything yet 😞", attributes: [NSForegroundColorAttributeName:UIColor.mainColor(), NSFontAttributeName:UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)])
    }
    
    func descriptionForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string: "Go to the meal tab and find a meal to enjoy !", attributes: [NSForegroundColorAttributeName:UIColor.mainColor(), NSFontAttributeName:UIFont.preferredFontForTextStyle(UIFontTextStyleBody)])
    }
    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        self.performSegueWithIdentifier("showMealVC", sender: self.viewModel.dataSource.meals[indexPath.row] )
//    }
//    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
