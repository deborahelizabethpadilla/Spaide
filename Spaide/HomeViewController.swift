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
import SVProgressHUD

class HomeViewController: UIViewController, UITextFieldDelegate, GADBannerViewDelegate {
    
    //Outlets
    
    @IBOutlet var bannerView: GADBannerView!
    @IBOutlet var changeEmail: UITextField!
    @IBOutlet var changePassword: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Keyboard Notifications
        
        NotificationCenter.default.addObserver(self, selector: #selector(Login.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(Login.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
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
        dismiss(animated: true, completion: nil)
    
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
        
        SVProgressHUD.show(withStatus: "Updating Email...")
        
        if let user = Auth.auth().currentUser {
            
            user.updateEmail(to: changeEmail.text!, completion: { (error) in
                
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    
                    SVProgressHUD.dismiss()
                    
                    self.displayAlert(title: "Success!", message: "Updated Email!")
                }
            })
        }
    }
   
    @IBAction func updatePasswordAction(_ sender: Any) {
        
        SVProgressHUD.show(withStatus: "Updating Password...")
        
        if let user = Auth.auth().currentUser {
            
            user.updatePassword(to: changePassword.text!, completion: { (error) in
                
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    
                   SVProgressHUD.dismiss()
                }
            })
        }
        
    }
    
    @IBAction func deleteAction(_ sender: Any) {
        
        SVProgressHUD.show(withStatus: "Deleting Account...")
        
        let user = Auth.auth().currentUser
        user?.delete(completion: { (error) in
            if let error = error {
                
                print(error.localizedDescription)
            } else {
                
                SVProgressHUD.dismiss()
                
                self.displayAlert(title: "Success!", message: "Your Account Is Deleted!")
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
    
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }

    
} // End Class
