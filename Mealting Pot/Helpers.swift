//
//  Helpers.swift
//  Mealting Pot
//
//  Created by Valentin Pertuisot on 23/08/15.
//  Copyright © 2015 power. All rights reserved.
//

import Foundation

class Helpers
{
    class func isValidEmail(testStr:String?) -> Bool {
        
        guard testStr != nil else {
            return false
        }
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluateWithObject(testStr)
        
        return result
    }
}