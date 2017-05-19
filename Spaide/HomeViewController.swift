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

class HomeViewController: UIViewController, UITextFieldDelegate, GADBannerViewDelegate {
    
    //Outlets
    
    @IBOutlet var bannerView: GADBannerView!
    @IBOutlet var changeEmail: UITextField!
    @IBOutlet var changePassword: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Load Banner View

        loadBanner()
        
        //Close Keyboard With Tap
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
        
        //Close Keyboard With Return Key
        
        self.changeEmail.delegate = self
        self.changePassword.delegate = self
    }
    
    //Actions
    
    @IBAction func logoutAction(_ sender: Any) {
        
        FacebookAPI.sharedInstance().logoutUser(controller: self)
    }
    
    //Banner View Info

    func loadBanner() {
        
        let request = GADRequest()
        request.testDevices = [kGADSimulatorID]
        bannerView.delegate = self
        bannerView.adUnitID = "pub-9793810674761024"
        bannerView.load(request)
        
    }
    
    @IBAction func updateAction(_ sender: Any) {
        
        if let user = Auth.auth().currentUser {
            
            user.updateEmail(to: changeEmail.text!, completion: { (error) in
                
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    
                    self.displayAlert(title: "Oh Snap!", message: "Could Not Change Email! Try Again!")
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
                    
                   self.displayAlert(title: "Oh Snap!", message: "Could Not Change Password! Try Again!")
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
                
                self.displayAlert(title: "Success!", message: "We Are Sorry To See You Go! Your Account Is Deleted!")
            }
        })
    }
    
    //Close Keyboard With Tap
    
    func dismissKeyboard() {
        
        //Close On Tap
        
        view.endEditing(true)
    }
    
    //Close Keyboard With Return Key
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        //Close On Return
        
        self.view.endEditing(true)
        return false
    }
    
    //Display Alert
    
    func displayAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            self.dismiss(animated: true, completion: nil)
            
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }

    
} // End Class
