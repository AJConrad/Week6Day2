//
//  AppDelegate.swift
//  BEForClass
//
//  Created by Thomas Crawford on 5/15/16.
//  Copyright © 2016 VizNetwork. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let APP_ID = "C82D598B-A9C7-3878-FFD5-FB3854D58500"
    let SECRET_KEY = "D95E0B5A-2BFC-D5BA-FFAC-39DC19E27900"
    let VERSION_NUM = "v1"
    
    var backendless = Backendless.sharedInstance()
    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        backendless.initApp(APP_ID, secret:SECRET_KEY, version:VERSION_NUM)
        return true
    }

}

