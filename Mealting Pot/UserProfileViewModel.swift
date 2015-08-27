//
//  UserProfileViewModel.swift
//  Mealting Pot
//
//  Created by Valentin Pertuisot on 14/08/15.
//  Copyright © 2015 power. All rights reserved.
//

import Foundation
import RealmSwift
import Alamofire
import SwiftyJSON
import SVProgressHUD

class UserProfileViewModel {
    var username = ""
    var description = ""
    var user = ConfigurationManager.user
    convenience init(userId: String) {
        self.init()
        updateModel()
    }
    
    func updateModel() -> Void {
        if let user = user {
            username = user.name
            description = user.userDescription
        }
    }
    
    func getSelf(completion : (success : Bool, pictureURL : NSURL?) -> Void) {
        Alamofire.request(Router.GetSelf)
            .validate()
        .responseJSON { (_, _, result) -> Void in
            switch result {
            case .Success(let value):
                let jsonSelf = JSON(value)
                let user = Person(jsonDict: jsonSelf)
                user.save()
                
                //TODO : Profile picture retrieval
                
            case .Failure:
                if let error = result.error as? NSError {
                    SVProgressHUD.showErrorWithStatus(error.localizedDescription)
                }
            }
        }
    }
    
    func logOut() {
        ConfigurationManager.userId = nil
        Router.accessToken = nil
    }
}