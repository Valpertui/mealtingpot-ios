//
//  BaseTabBarController.swift
//  Mealting Pot
//
//  Created by Valentin Pertuisot on 22/08/15.
//  Copyright © 2015 power. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {

    @IBInspectable var defaultIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedIndex = defaultIndex
        // Do any additional setup after loading the view.
    }

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
