//
//  AppDelegate.swift
//  Spaide
//
//  Created by Deborah on 3/9/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var databaseRef: FIRDatabaseReference!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //Configure Firebase API's
        
        FIRApp.configure()
        
        self.databaseRef = FIRDatabase.database().reference()
        
        return true
    }

}

