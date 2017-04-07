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
        
        signOut()
    }
    
    
    func signOut() {
        
        try! FIRAuth.auth()!.signOut()
        if let storyboard = self.storyboard {
            let vc = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! UINavigationController
            self.present(vc, animated: false, completion: nil)
        }
    }
}
