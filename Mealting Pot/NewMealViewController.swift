//
//  NewMealViewController.swift
//  Mealting Pot
//
//  Created by Valentin Pertuisot on 22/08/15.
//  Copyright © 2015 power. All rights reserved.
//

import UIKit
import SZTextView
import CoreLocation

class NewMealViewController: UIViewController , UITableViewDelegate, CLLocationManagerDelegate, UIImagePickerControllerDelegate , UINavigationControllerDelegate {

    @IBOutlet weak var mealPicture: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextView: SZTextView!
    @IBOutlet weak var formatTextField: UITextField!
    @IBOutlet weak var cuisineTextField: UITextField!
    @IBOutlet weak var dishesTableView: UITableView!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var refreshLocationButton: UIButton!
    
    @IBOutlet weak var maxNumberOfParticipantsTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    let addDishesDataSource = AddDishesDataSource()
    let viewModel = NewMealViewModel()
    
    var tmpAddDishViewModel : AddDishViewModel?
    
    let locationManager = CLLocationManager()
    let geocoder = CLGeocoder()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dishesTableView.dataSource = addDishesDataSource
        
        let datePickerView = UIDatePicker()
        let toolBar = UIToolbar()
        toolBar.barStyle = .Default
        toolBar.translucent = true
        toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .Plain, target: self, action: "datePickerDone")
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.userInteractionEnabled = true
        
        dateTextField.inputView = datePickerView
        dateTextField.inputAccessoryView = toolBar
        datePickerView.addTarget(self, action: "datePickerValueChanged:", forControlEvents: .ValueChanged)
        
        locationManager.delegate = self
        
        let singleTap = UITapGestureRecognizer(target: self, action: "editPictureTouched")
        singleTap.numberOfTapsRequired = 1
        
        mealPicture.userInteractionEnabled = true
        mealPicture.addGestureRecognizer(singleTap)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        updateDishes()
    }
    
    override func viewWillDisappear(animated: Bool) {
        locationManager.stopUpdatingLocation()
        super.viewWillDisappear(animated)
    }

    
    func editPictureTouched() -> Void {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .Camera
        self.presentViewController(picker, animated: true, completion: nil)
        
    }
    
    func datePickerDone() -> Void {
        dateTextField.resignFirstResponder()
    }
    
    func datePickerValueChanged(sender:UIDatePicker)
    {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .MediumStyle
        dateFormatter.timeStyle = .ShortStyle
        viewModel.date = sender.date.copy() as! NSDate
        dateTextField.text = dateFormatter.stringFromDate(sender.date)
    }
    
    @IBAction func refreshLocationTouched(sender: UIButton) {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        let canUseLocationNotifications = (status == .AuthorizedWhenInUse)
        if canUseLocationNotifications {
            manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            manager.startUpdatingLocation()
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        _ = locations.map {location in
            
            viewModel.locationProvided = true
            viewModel.longitude = location.coordinate.longitude
            viewModel.latitude = location.coordinate.latitude
            
            geocoder.reverseGeocodeLocation(CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)) { (placemarks, error) -> Void in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                guard let placemarks = placemarks else {
                    self.locationLabel.text = "No address found"
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
    }
    
    func updateDishes() -> Void {
        guard let dishViewModel = tmpAddDishViewModel where dishViewModel.saved == true else {
            return
        }
        addDishesDataSource.dishes.append(dishViewModel.getDish())
        
        dishesTableView.beginUpdates()
        dishesTableView.insertRowsAtIndexPaths([NSIndexPath(forRow: addDishesDataSource.dishes.count - 1, inSection: 0)], withRowAnimation: .Automatic)
        dishesTableView.endUpdates()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.section {
        case 0:
            break
        case 1:
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
            performSegueWithIdentifier("showAddDishVC", sender: nil)
        default:
            break
        }
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        viewModel.chosenImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        mealPicture.image = viewModel.chosenImage
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func cancelMeal(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func saveMeal(sender: AnyObject) {
        guard let title = titleTextField.text where title.length > 0 else {
            return
        }
        viewModel.title = title
        
        guard addDishesDataSource.dishes.count > 0 else {
            return
        }
        viewModel.dishes = addDishesDataSource.dishes
        
        guard let cuisine = cuisineTextField.text where cuisine.length > 0 else {
            return
        }
        viewModel.cuisine = cuisine
        
        viewModel.description = descriptionTextView.text

        if let format = formatTextField.text {
            viewModel.format = format
        }
        if let seatsNumber = Int(maxNumberOfParticipantsTextField.text!) where seatsNumber > 0 && seatsNumber <= 100 {
            viewModel.seatsNumber = seatsNumber
        }
        if let price = priceTextField.text {
            let converter = NSNumberFormatter()
            if  price.containsString(",") {
                converter.decimalSeparator = ","
            }
            let price = converter.numberFromString(price)!
            viewModel.price = price.doubleValue
        }
        
        viewModel.postMeal()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        guard segue.identifier != nil else {
            return
        }
        switch segue.identifier! {
            case "showAddDishVC":
                let destVC = segue.destinationViewController as! AddDishViewController
                let viewModel = AddDishViewModel()
                destVC.viewModel = viewModel
                tmpAddDishViewModel = viewModel
            default:
                return
        }
    }
    

}
