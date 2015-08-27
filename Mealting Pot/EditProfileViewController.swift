//
//  EditProfileViewController.swift
//  Mealting Pot
//
//  Created by Valentin Pertuisot on 22/08/15.
//  Copyright © 2015 power. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {

    let viewModel = EditUserViewModel()
    
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        usernameTextField.text = viewModel.username
        descriptionTextField.text = viewModel.description
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveTouched(sender: AnyObject) {
        if let username = usernameTextField.text where username.length > 2{
            viewModel.username = username
        }
        if let description = descriptionTextField.text {
            viewModel.description = description
        }
        viewModel.editSelf()
    }

    @IBAction func cancelTouched(sender: AnyObject) {
        //self.resignFirstResponder()
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
