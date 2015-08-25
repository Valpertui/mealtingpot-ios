//
//  ConfigurationManager.swift
//  Mealting Pot
//
//  Created by Valentin Pertuisot on 23/08/15.
//  Copyright © 2015 power. All rights reserved.
//

import Foundation
import RealmSwift

class ConfigurationManager {
    static let sharedInstance = ConfigurationManager()
    
    static var userId: String? {
        get {
        return NSUserDefaults.standardUserDefaults().stringForKey("user_id")
        }
        set {
            NSUserDefaults.standardUserDefaults().setObject(newValue, forKey: "user_id")
        }
    }
    
    static var user : Person? {
        get {
            guard let userId = ConfigurationManager.userId else {
                return nil
            }
            return try! Realm().objects(Person).filter("id == %@", userId)[0]
        }
    }
    
}