//
//  RegisterViewModel.swift
//  Mealting Pot
//
//  Created by Valentin Pertuisot on 23/08/15.
//  Copyright © 2015 power. All rights reserved.
//

import Foundation
import Alamofire
import SVProgressHUD
import SwiftyJSON

class RegisterViewModel
{
    var password: String = ""
    var email: String = ""
    var username: String = ""
    
    func register(completion: (success: Bool) -> Void) -> Void
    {
        Alamofire.request(Router.RegisterUser(username: username, email: email, password: password))
            .validate()
            .responseJSON { (_, urlRequest, result) -> Void in
                debugPrint(urlRequest)
                switch result {
                case .Success(let value):
                    let user = Person(jsonDict:JSON(value))
                    user.save()
                    ConfigurationManager.userId = user.id
                    
                    Alamofire.request(Router.GetJwt(email: self.email, password: self.password))
                        .validate()
                        .responseJSON { (_, _, result) -> Void in
                            switch result {
                            case .Success(let value):
                                var json = JSON(value)
                                if let access_token = json["access_token"].string {
                                    Router.accessToken = access_token
                                    SVProgressHUD.showSuccessWithStatus("Successfully registred")
                                    completion(success: true)
                                }
                                else
                                {
                                    print("No access token found")
                                    completion(success: false)
                                }
                            case .Failure:
                                if let error = result.error as? NSError {
                                    SVProgressHUD.showErrorWithStatus(error.localizedDescription)
                                }
                                completion(success: false)
                            }
                            
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