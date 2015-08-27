//
//  AddDishViewController.swift
//  Mealting Pot
//
//  Created by Valentin Pertuisot on 25/08/15.
//  Copyright © 2015 power. All rights reserved.
//

import UIKit

class AddDishViewController: UIViewController {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var dishDescription: UITextField!
    @IBOutlet weak var type: UITextField!
    var viewModel : AddDishViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelTouched(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func saveTouched(sender: AnyObject) {
        guard let name = name.text where name.length > 0 else {
            return
        }
        guard let viewModel = self.viewModel else {
            return
        }
        
        viewModel.name = name
        if let dishDescription = dishDescription.text {
            viewModel.dishDescription = dishDescription
        }
        if let type = type.text {
            viewModel.type = type
        }
        viewModel.saved = true
        self.navigationController?.popViewControllerAnimated(true)
    }
}
