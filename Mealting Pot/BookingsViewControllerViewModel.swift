//
//  BookingsViewControllerViewModel.swift
//  Mealting Pot
//
//  Created by Valentin Pertuisot on 26/08/15.
//  Copyright © 2015 power. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import RealmSwift

class BookingsViewControllerViewModel {
    
    let dataSource = BookingsDataSource()
    
    func refreshBookings(completion : (success: Bool) -> Void) -> Void {
        Alamofire.request(Router.GetSelfBookings)
            .validate()
            .responseJSON { (_, _, result) -> Void in
                switch result {
                case .Success(let value):
                    let json = JSON(value)
                    self.updateDBFromResponse(json)
                    completion(success: true)
                case .Failure:
                    if let error = result.error as? NSError {
                        print(error)
                    }
                    completion(success: false)
                }
        }
    }
    
    func updateDBFromResponse(json: JSON) -> Void {
        
//        let realm = try! Realm()
//        realm.write {
//            realm.delete(realm.objects(Booking).filter("id == %@", ConfigurationManager.user!.id))
//        }
        
        _ = json.arrayValue.map({ bookingJson in
            let booking = Booking(jsonDict: bookingJson)
            booking.save()
            
        })
    }
}