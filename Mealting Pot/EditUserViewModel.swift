//
//  EditUserViewModel.swift
//  Mealting Pot
//
//  Created by Valentin Pertuisot on 26/08/15.
//  Copyright © 2015 power. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift
import SwiftyJSON
import SVProgressHUD

class EditUserViewModel {
    var username = ""
    var description = ""
    var user = ConfigurationManager.user
    
    init() {
        guard let user = user else {
            return
        }
        username = user.name
        description = user.userDescription
    }
    
    func editSelf() -> Void {
        Alamofire.request(Router.EditUser(["username":username, "bio":description]))
            .validate()
            .responseJSON { (_, _, result) -> Void in
                switch result {
                case .Success(let value):
                    let jsonUser = JSON(value)
                    let user = Person(jsonDict: jsonUser)
                    user.save()
                case .Failure:
                    if let error = result.error as? NSError {
                        SVProgressHUD.showErrorWithStatus(error.localizedDescription)
                    }
                }
            }
    }
}