//
//  LoginViewController.swift
//  Spaide
//
//  Created by Deborah on 3/9/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import SVProgressHUD

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    //Outlets
    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var registerButton: UIButton!
    @IBOutlet var loginButton: UIButton!
    //Actions
    @IBAction func signinAction(_ sender: Any) {
        
        login()
    }
    
    @IBAction func termsButton(_ sender: Any) {
        let url = URL(string: "http://www.spaideapp.com")!
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Button Designs
        
        let myColor = UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 1.0)
        
        emailField.layer.cornerRadius = 15.0
        emailField.layer.borderWidth = 2.0
        emailField.layer.borderColor = myColor.cgColor
        passwordField.layer.cornerRadius = 15.0
        passwordField.layer.borderWidth = 2.0
        passwordField.layer.borderColor = myColor.cgColor
        
        loginButton.layer.cornerRadius = 15.0
        registerButton.layer.cornerRadius = 15.0
        
        //Close Keyboard With Tap
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
        
        //Close Keyboard With Return Key
        
        self.emailField.delegate = self
        self.passwordField.delegate = self
        
    }
    
    func login() {
        
        if self.emailField.text == "" || self.passwordField.text == "" {
            
            //Show Error
            
            SVProgressHUD.showError(withStatus: "Please Enter Your Info!")
            
        } else {
            
            //Sign in
            
            SVProgressHUD.setStatus("Signing In")
            
            Auth.auth().signIn(withEmail: self.emailField.text!, password: self.passwordField.text!, completion: { (user, error) in
                if error == nil {
                    
                    SVProgressHUD.dismiss()
                    
                    //Go To Controller
                    
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeView")
                    self.present(vc!, animated: true, completion: nil)
                }
            })
        }
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
    
} //End Class
