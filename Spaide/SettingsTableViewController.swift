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
import MessageUI

class SettingsTableViewController: UITableViewController, UITextFieldDelegate, MFMailComposeViewControllerDelegate {
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
        
        let emailTitle = "General Questions"
        let messageBody = "Have a question? Need help? Tell us here..."
        let toRecipents = ["spaideapp@gmail.com"]
        let mc: MFMailComposeViewController = MFMailComposeViewController()
        mc.mailComposeDelegate = self
        mc.setSubject(emailTitle)
        mc.setMessageBody(messageBody, isHTML: false)
        mc.setToRecipients(toRecipents)
        
        self.present(mc, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        switch result {
            
        case .cancelled:
            print("Mail Cancelled")
            
        case .saved:
            print("Mail Saved")
            
        case .sent:
            print("Mail Sent")
            
        default:
            break
        }
        
        //Close Mail Interface
        
        self.dismiss(animated: true, completion: nil)
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
        tableView.allowsSelection = false
        //Text Designs
        
        let myColor = UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 1.0)
        emailField.layer.cornerRadius = 15.0
        emailField.layer.borderWidth = 2.0
        emailField.layer.borderColor = myColor.cgColor
        passwordField.layer.cornerRadius = 15.0
        passwordField.layer.borderWidth = 2.0
        passwordField.layer.borderColor = myColor.cgColor
        
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
