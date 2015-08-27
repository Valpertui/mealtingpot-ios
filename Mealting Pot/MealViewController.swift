//
//  MealViewController.swift
//  Mealting Pot
//
//  Created by Valentin Pertuisot on 20/08/15.
//  Copyright © 2015 power. All rights reserved.
//

import UIKit
import SZTextView
import CoreLocation
import SVProgressHUD

class MealViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var mealPicture: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextView: SZTextView!
    @IBOutlet weak var formatTextField: UITextField!
    @IBOutlet weak var cuisineTextField: UITextField!
    @IBOutlet weak var dishesTableView: UITableView!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var seatsTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    
    let dishesDataSource = DishesDataSource()
    var viewModel : MealViewModel?
    
    let geocoder = CLGeocoder()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dishesTableView.dataSource = dishesDataSource
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
        dishesTableView.reloadData()
    }
    
    func updateUI() -> Void {
        guard let viewModel = viewModel else {
            return
        }
        titleTextField.text = viewModel.title
        descriptionTextView.text = viewModel.description
        formatTextField.text = viewModel.format
        cuisineTextField.text = viewModel.cuisine
        dishesDataSource.dishes = viewModel.dishes
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .MediumStyle
        dateFormatter.timeStyle = .ShortStyle
        dateTextField.text = dateFormatter.stringFromDate(viewModel.date)
        seatsTextField.text = "\(viewModel.reservedSeats) / \(viewModel.seatsNumber)"
        priceTextField.text = "£\(viewModel.price)"
        self.locationLabel.text = "Searching ..."
        geocoder.reverseGeocodeLocation(CLLocation(latitude: viewModel.latitude, longitude: viewModel.longitude)) { (placemarks, error) -> Void in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let placemarks = placemarks else {
                self.locationLabel.text = "No address"
                return
            }
            _ = placemarks.map { placemark in
                var address = ""
                if let subThrougfare = placemark.subThoroughfare {
                    address += "\(subThrougfare) "
                }
                if let thoroughfare = placemark.thoroughfare {
                    address += "\(thoroughfare) "
                }
                if let locality = placemark.locality {
                    address += "\(locality)"
                }
                guard address != "" else {
                    return
                }
                self.locationLabel.text = address
                return
            }
        }
    }

    @IBAction func bookPressed(sender: AnyObject) {
        guard let viewModel = viewModel else {
            return
        }
        if viewModel.seatsNumber - viewModel.reservedSeats <= 0 {
            SVProgressHUD.showErrorWithStatus("Not enough seats remaining")
        }
        viewModel.bookMeal()
        self.navigationController?.popViewControllerAnimated(true)
    }
    
}
