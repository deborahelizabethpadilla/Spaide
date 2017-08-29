//
//  SettingsTableViewController.swift
//  Spaide
//
//  Created by Deborah on 8/28/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import SVProgressHUD

class SettingsTableViewController: UITableViewController, UITextFieldDelegate {
    //Outlets
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    //Actions
    @IBAction func saveEmail(_ sender: Any) {
        updateEmail()
    }
    
    @IBAction func savePassword(_ sender: Any) {
        updatePassword()
    }
    
    @IBAction func contactAction(_ sender: Any) {
        
    }
    
    @IBAction func signOut(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func deleteAccount(_ sender: Any) {
        deleteAccount()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Close Keyboard With Return Key
        
        self.emailField.delegate = self
        self.passwordField.delegate = self
        
        //Close Keyboard With Tap
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SettingsTableViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
        
    }
    
    //Functions
    
    func dismissKeyboard() {
        
        //Close Keyboard On Tap
        
        view.endEditing(true)
    }

    func updateEmail() {
        
        SVProgressHUD.show(withStatus: "Updating Email...")
        
        if let user = Auth.auth().currentUser {
            
            user.updateEmail(to: emailField.text!, completion: { (error) in
                
                if let error = error {
                    print(error.localizedDescription)
                    
                    SVProgressHUD.dismiss()
                    SVProgressHUD.showError(withStatus: "Email Update Failed!")
                    
                } else {
                    
                    SVProgressHUD.dismiss()
                }
            })
        }
    }
    
    func updatePassword() {
        
        
        SVProgressHUD.show(withStatus: "Updating Password...")
        
        if let user = Auth.auth().currentUser {
            
            user.updatePassword(to: passwordField.text!, completion: { (error) in
                
                if let error = error {
                    print(error.localizedDescription)
                    
                    SVProgressHUD.dismiss()
                    SVProgressHUD.showError(withStatus: "Password Update Failed!")
                    
                } else {
                    
                    SVProgressHUD.dismiss()
                }
            })
        }
    }
    
    func deleteAccount() {
        
        SVProgressHUD.show(withStatus: "Deleting Account...")
        
        let user = Auth.auth().currentUser
        user?.delete(completion: { (error) in
            if let error = error {
                
                print(error.localizedDescription)
                
                SVProgressHUD.dismiss()
                
                SVProgressHUD.showError(withStatus: "Failed To Delete Account!")
                
            } else {
                
                SVProgressHUD.dismiss()
            }
        })
    }

} //End Class
