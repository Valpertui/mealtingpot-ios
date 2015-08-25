//
//  RegisterViewController.swift
//  Mealting Pot
//
//  Created by Valentin Pertuisot on 19/08/15.
//  Copyright © 2015 power. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class RegisterViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    var registerViewModel : RegisterViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        registerButton.addTarget(self, action: "registerPressed", forControlEvents: .TouchUpInside)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func registerPressed() -> Void
    {
        guard (Helpers.isValidEmail(emailTextField.text) && passwordTextField.text?.length >= 6 && usernameTextField.text?.length >= 2) else
        {
            if Helpers.isValidEmail(emailTextField.text) == false
            {
                SVProgressHUD.showErrorWithStatus("You need to enter a valid email address")
            }
            else if passwordTextField.text?.length < 6 {
                SVProgressHUD.showErrorWithStatus("Your password should be at least 6 characters long")
            }
            else if (usernameTextField.text?.length < 2)
            {
                SVProgressHUD.showErrorWithStatus("Your username should be at least 2 characters long")
            }
            return
        }
        
        registerViewModel.email = emailTextField.text!
        registerViewModel.password = passwordTextField.text!
        registerViewModel.username = usernameTextField.text!
        
        registerViewModel.register { (success : Bool) -> Void in
            if success
            {
                self.performSegueWithIdentifier("loggedIn", sender: self)
            }
        }

    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        switch textField {
        case passwordTextField:
            textField.resignFirstResponder()
        case emailTextField:
            passwordTextField.becomeFirstResponder()
        case usernameTextField:
            emailTextField.becomeFirstResponder()
        default:
            break
        }
        return true
    }

    @IBAction func backButtonTouched(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
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
