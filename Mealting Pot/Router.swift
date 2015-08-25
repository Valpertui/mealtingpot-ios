//
//  Router.swift
//  Mealting Pot
//
//  Created by Valentin Pertuisot on 23/08/15.
//  Copyright © 2015 power. All rights reserved.
//

import Alamofire

enum Router: URLRequestConvertible {
    static let baseURLString = "https://mealting-pot.herokuapp.com"
    static var accessToken: String? {
        get {
            return NSUserDefaults.standardUserDefaults().stringForKey("access_token")
        }
        set {
            NSUserDefaults.standardUserDefaults().setObject(newValue, forKey: "access_token")
        }
    }
    
    case RegisterUser(username: String, email: String, password: String)
    case GetUser(userId: String)
    case GetSelf
    case UpdateUser([String: AnyObject])
    case DestroyUser
    case GetJwt(email: String, password: String)
    case GetMeals([String: AnyObject])
    
    var method: Alamofire.Method {
        switch self {
        case .RegisterUser:
            return .POST
        case .GetSelf:
            return .GET
        case .GetUser:
            return .GET
        case .UpdateUser:
            return .PUT
        case .DestroyUser:
            return .DELETE
        case .GetJwt:
            return .GET
        case .GetMeals:
            return .GET
        }
    }
    
    var path: String {
        switch self {
        case .RegisterUser:
            return "/users"
        case .GetSelf:
            return "/users/me"
        case .GetUser(let userId):
            return "/users/\(userId)"
        case .UpdateUser:
            return "/users/me"
        case .DestroyUser:
            return "/users/me"
        case .GetJwt:
            return "/jwt"
        case .GetMeals:
            return "/meals"
        }
    }
    
    // MARK: URLRequestConvertible
    
    var URLRequest: NSMutableURLRequest {
        let URL = NSURL(string: Router.baseURLString)!
        let mutableURLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(path))
        mutableURLRequest.HTTPMethod = method.rawValue
        mutableURLRequest.setValue("application/json", forHTTPHeaderField: "Content-type")
        mutableURLRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        
        switch self {
        case .RegisterUser,.GetMeals:
            break
        case .GetJwt(let email, let password):
            let credentialData = "\(email):\(password)".dataUsingEncoding(NSUTF8StringEncoding)!
            let base64Credentials = credentialData.base64EncodedStringWithOptions([])
            mutableURLRequest.setValue("Basic \(base64Credentials)", forHTTPHeaderField: "Authorization")
        default:
            if let token = Router.accessToken {
                mutableURLRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            }
        }
    
        switch self {
        case .RegisterUser(_, let email, let password):
            return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: ["email": email, "password": password]).0
        case .UpdateUser(let parameters):
            return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: parameters).0
        case .GetMeals(let parameters):
            return Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: parameters).0
        default:
            return mutableURLRequest
        }
    }
}