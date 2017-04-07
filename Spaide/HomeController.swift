//
//  HomeController.swift
//  Spaide
//
//  Created by Deborah on 4/7/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import UIKit
import ChameleonFramework
import Firebase
import FirebaseAuth

class HomeController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Background Color
        
        view.backgroundColor = FlatWhite()
    }
    
    //Actions
    
    @IBAction func logoutButton(_ sender: Any) {
        
        let firebaseAuth = FIRAuth.auth()
        do {
            try firebaseAuth?.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
}
