//
//  LoginViewModel.swift
//  Mealting Pot
//
//  Created by Valentin Pertuisot on 24/08/15.
//  Copyright © 2015 power. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import SVProgressHUD

class LoginViewModel
{
    var password: String = ""
    var email: String = ""
    
    func login(completion: (success: Bool) -> Void) -> Void
    {
        Alamofire.request(Router.GetJwt(email: self.email, password: self.password))
            .validate()
            .responseJSON { (_, _, result) -> Void in
                switch result {
                case .Success(let value):
                    print(value)
                    var json = JSON(value)
                    if let access_token = json["access_token"].string {
                        Router.accessToken = access_token
                        SVProgressHUD.showSuccessWithStatus("Successfully registred")
                        completion(success: true)
                        Alamofire.request(Router.GetSelf)
                            .validate()
                            .responseJSON(completionHandler: { (_, _, result) -> Void in
                                switch result {
                                case .Success(let value):
                                    let user = Person(jsonDict:JSON(value))
                                    user.save()
                                    ConfigurationManager.userId = user.id
                                case .Failure:
                                    if let error = result.error as? NSError {
                                        print(error)
                                    }
                                }
                            })
                        
                    }
                    else
                    {
                        print("No access token found")
                        SVProgressHUD.showErrorWithStatus("An unknown error occured, try again later")
                        completion(success: false)
                    }
                case .Failure:
                    if let error = result.error as? NSError {
                        SVProgressHUD.showErrorWithStatus(error.localizedDescription)
                    }
                    completion(success: false)
                }
                
        }

    }

}