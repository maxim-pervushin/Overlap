//
//  AppDelegate.swift
//  Overlap
//
//  Created by Maxim Pervushin on 08/04/16.
//  Copyright © 2016 Maxim Pervushin. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        Fabric.with([Crashlytics.self])
        applyAppearance()
        return true
    }


    private func applyAppearance() {
        
        // UITableView
        UITableView.appearance().separatorColor = UIColor(red:0.93, green:0.94, blue:0.95, alpha:1.00).colorWithAlphaComponent(0.25)
    }
}
