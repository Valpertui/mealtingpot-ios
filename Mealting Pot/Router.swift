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
    case PostMeal([String: AnyObject])
    case PostPictureForMeal(mealId: String)
    case GetPicturesForMeal(mealId: String)
    case EditUser([String: AnyObject])
    case BookMeal(mealId: String, seats: Int)
    case GetSelfBookings
    
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
        case .PostMeal:
            return .POST
        case .PostPictureForMeal:
            return .POST
        case .GetPicturesForMeal:
            return .GET
        case .EditUser:
            return .PUT
        case .BookMeal:
            return .POST
        case .GetSelfBookings:
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
        case .PostMeal:
            return "/meals"
        case .PostPictureForMeal(let mealId):
            return "/meals/\(mealId)/pictures"
        case .GetPicturesForMeal(let mealId):
            return "/meals/\(mealId)/pictures"
        case .EditUser:
            return "/users/me"
        case .BookMeal(let mealId, _):
            return "/meals/\(mealId)/bookings"
        case .GetSelfBookings:
            return "/users/me/bookings"
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
        case .PostMeal(let parameters):
            return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: parameters).0
        case .GetMeals(let parameters):
            return Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: parameters).0
        case .PostPictureForMeal:
            return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: ["name": NSUUID().UUIDString, "type":"img/jpeg"]).0
        case .EditUser(let parameters):
            return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: parameters).0
        case .BookMeal(_, let seats):
            return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: ["seats": seats]).0
        default:
            return mutableURLRequest
        }
    }
}