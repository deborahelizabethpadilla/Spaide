//
//  RegisterTableViewController.swift
//  Spaide
//
//  Created by Deborah on 8/30/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import UIKit
import SVProgressHUD
import Firebase
import FirebaseAuth
import FirebaseDatabase

class RegisterTableViewController: UITableViewController {
    //Outlets
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    //Actions
    @IBAction func registerAction(_ sender: Any) {
        register()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //Button Designs
        registerButton.layer.cornerRadius = 15.0
        backButton.layer.cornerRadius = 15.0
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
    func register() {
        
        //Error
        
        if emailField.text == "" || passwordField.text == "" {
            
            SVProgressHUD.showError(withStatus: "Please Enter Your Info!")
            
        } else {
            
            //Login
            
            SVProgressHUD.show(withStatus: "Creating User")
            Auth.auth().createUser(withEmail: emailField.text!, password: passwordField.text!, completion: { (user, error) in
                if error == nil {
                    
                    SVProgressHUD.dismiss()
                    
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeView")
                    self.present(vc!, animated: true, completion: nil)
                }
            })
        }
    }

} //End Class
