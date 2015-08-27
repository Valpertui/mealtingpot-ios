//
//  ProfileViewController.swift
//  Mealting Pot
//
//  Created by Valentin Pertuisot on 20/08/15.
//  Copyright © 2015 power. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var profilePictureImageView: InspectableImageView!
    let viewModel = UserProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.updateModel()
        usernameLabel.text = viewModel.username
        descriptionLabel.text = viewModel.description
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logOut(sender: AnyObject) {
        let controller: UIAlertController = UIAlertController(
            title: "Log out",
            message: "Do you really want to log out ?",
            preferredStyle: .ActionSheet
        )
        
        controller.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        
        controller.addAction(UIAlertAction(title: "Confirm", style: .Destructive) { action in
            guard let logInVC = UIStoryboard(name: "LoginStoryboard", bundle: NSBundle.mainBundle()).instantiateInitialViewController() else
            {
                return
            }
            if let window = (UIApplication.sharedApplication().delegate as! AppDelegate).window {
                self.viewModel.logOut()
                window.rootViewController = logInVC
                window.makeKeyAndVisible()
            }
            })
        
        controller.popoverPresentationController?.sourceView = sender as? UIView
        
        presentViewController(controller, animated: true, completion: nil)
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
