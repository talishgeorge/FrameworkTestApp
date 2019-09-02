//
//  AppDelegate.swift
//  Airports
//
//  Created by Talish George on 6/4/19.
//  Copyright © 2019 Airports. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UIApplication.shared.isStatusBarHidden = false
        return true
    }
}
extension UIApplication{
    var statusBarView: UIView?{
        return value(forKey: "statusBar") as? UIView
    }
}
