//
//  BannerViewController.swift
//  Spaide
//
//  Created by Deborah on 5/10/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import UIKit
import GoogleMobileAds
import Firebase
import FirebaseDatabase
import FirebaseAuth

class HomeViewController: UIViewController {
    
    //Firebase
    
    var databaseRef: DatabaseReference! {
        return Database.database().reference
    }
    
    //Outlets
    
    @IBOutlet var bannerView: GADBannerView!
    @IBOutlet var changeEmail: UITextField!
    @IBOutlet var changePassword: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Load Banner View

        loadBanner()
    }
    
    //Actions
    
    @IBAction func logoutAction(_ sender: Any) {
        
        FacebookAPI.sharedInstance().logoutUser(controller: self)
    }
    
    //Banner View Info

    func loadBanner() {
        
        bannerView = GADBannerView(adSize: kGADAdSizeLargeBanner)
        self.view.addSubview(bannerView)
        bannerView.adUnitID = "pub-9793810674761024"
        bannerView.rootViewController = self
        bannerView.load(GADRequest)
        
    }
    
    @IBAction func updateAction(_ sender: Any) {
        
        if let user = Auth.auth().currentUser {
            
            user.updateEmail(to: changeEmail.text!, completion: { (error) in
                
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    
                    let alertView = UIAlertView(title: "Oh Snap!", message: "Could Not Change Email!", delegate: self, cancelButtonTitle: "OK")
                    alertView.show()
                }
            })
        }
    }
   
    @IBAction func updatePasswordAction(_ sender: Any) {
        
        if let user = Auth.auth().currentUser {
            
            user.updatePassword(to: changePassword.text!, completion: { (error) in
                
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    
                    let alertView = UIAlertView(title: "Oh Snap!", message: "Could Not Change Password!", delegate: self, cancelButtonTitle: "OK")
                    alertView.show()
                }
            })
        }
        
    }
    
    @IBAction func deleteAction(_ sender: Any) {
        
        let user = Auth.auth().currentUser
        user?.delete(completion: { (error) in
            if let error = error {
                
                print(error.localizedDescription)
            } else {
                
                let alertView = UIAlertView(title: "Delete Account", message: "We Are Sorry You're Leaving! You Have Successfully Deleted Your Account!", delegate: self, cancelButtonTitle: "OK")
                alertView.show()
            }
        })
    }
}
