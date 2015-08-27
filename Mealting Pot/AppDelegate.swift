//
//  AppDelegate.swift
//  Mealting Pot
//
//  Created by Valentin Pertuisot on 13/06/15.
//  Copyright © 2015 power. All rights reserved.
//

import UIKit
import RealmSwift
import BigBrother

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        // Override point for customization after application launch.
        guard let window = window else
        {
            return false
        }
        
        UITabBar.appearance().tintColor = UIColor.mainColor()
        
        // TODO: Implement LogIn Manager
        let loggedIn = Router.accessToken != nil;
        
        let mainVC : UIViewController
        
        if loggedIn
        {
            guard let homeVC = UIStoryboard(name: "MainStoryboard", bundle: NSBundle.mainBundle()).instantiateInitialViewController() else
            {
                return false
            }
            mainVC = homeVC
        }
        else
        {
            guard let logInVC = UIStoryboard(name: "LoginStoryboard", bundle: NSBundle.mainBundle()).instantiateInitialViewController() else
            {
                return false
            }
            mainVC = logInVC
        }

        window.rootViewController = mainVC
        window.backgroundColor = UIColor.whiteColor()
        window.makeKeyAndVisible()
        
        if false == true
        {
            try! Realm().seed()
        }
        
        //BigBrother.addToSharedSession()
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

