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
    var dataManager: DataManager?// = DataManager(storage: PlistStorage())
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        _initAnalytics()
        _initAppearance()
        _initDataManager()
        return true
    }

    // MARK: private

    
    private func _initAnalytics() {
        Fabric.with([Crashlytics.self])
    }

    private func _initAppearance() {
        
        // UITableView
        UITableView.appearance().separatorColor = UIColor(red:0.93, green:0.94, blue:0.95, alpha:1.00).colorWithAlphaComponent(0.25)
    }
    
    private func _initDataManager() {
        dataManager = DataManager(storage: PlistStorage())
        // TODO: Write error if dataManager is nil
    }
}

class App {
    
    static var dataManager: DataManager? {
        return (UIApplication.sharedApplication().delegate as? AppDelegate)?.dataManager
    }
    
}