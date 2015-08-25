//
//  OnboardingViewController.swift
//  Mealting Pot
//
//  Created by Valentin Pertuisot on 19/08/15.
//  Copyright © 2015 power. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segue.identifier! {
        case "showRegisterVC":
            let destVC = segue.destinationViewController as! RegisterViewController
            destVC.registerViewModel = RegisterViewModel()
        case "showLoginVC":
            let destVC = segue.destinationViewController as! LoginViewController
            destVC.loginViewModel = LoginViewModel()
            
        default:
            break
        }
    }

}
