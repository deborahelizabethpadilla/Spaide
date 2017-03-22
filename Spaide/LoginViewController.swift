//
//  LoginViewController.swift
//  Spaide
//
//  Created by Deborah on 3/9/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import UIKit
import ChameleonFramework
import Firebase

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    //Outlets
    
    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Close Keyboard With Return Key
        
        self.emailField.delegate = self
        self.passwordField.delegate = self
        
        //Close Keyboard With Tap
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
        
        //Set Background Color
        
        view.backgroundColor = FlatGreenDark()
        
        //Button Colors
        
        loginButton.backgroundColor = .flatWatermelonDark
        loginButton.layer.cornerRadius = 5
        loginButton.layer.borderWidth = 1
        loginButton.layer.borderColor = UIColor.flatWatermelonDark.cgColor
        
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
    
    //Actions
    
    @IBAction func loginButton(_ sender: Any) {
        
        FIRAuth.auth()?.createUser(withEmail: emailField.text!, password: passwordField.text!, completion: {
            user, error in
            
            if error != nil {
                
                self.login()
                
            } else {
                
                print("User Created")
                self.login()
            }
        })
        
    }
    
    //Create/Login Function
    
    func login() {
        
        FIRAuth.auth()?.signIn(withEmail: emailField.text!, password: passwordField.text!, completion: {
            user, error in
            
            if error != nil {
                
                print("Wrong!")
                
            } else {
                
                print("Logged In!")
            }
            
        })
    }
}
