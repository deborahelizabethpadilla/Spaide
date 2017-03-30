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
    
    //Variables
    
    var isSignIn:Bool = true
    
    //Outlets
    
    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var registerButton: UIButton!
    
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
        
        //Button Colors & Size
        
        loginButton.backgroundColor = .flatWatermelonDark
        loginButton.layer.cornerRadius = 5
        loginButton.layer.borderWidth = 1
        loginButton.layer.borderColor = UIColor.flatWatermelonDark.cgColor
        
        registerButton.backgroundColor = .flatWatermelonDark
        registerButton.layer.cornerRadius = 5
        registerButton.layer.borderWidth = 1
        registerButton.layer.borderColor = UIColor.flatWatermelonDark.cgColor
        
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
    
    @IBAction func registerButtonAction(_ sender: Any) {
        
        registerUser()
    }
    
    @IBAction func loginButton(_ sender: Any) {
        
        login()
    }
    
    //Create Login And Register Function
    
    func login() {
        
        //Validate Email And Password
        
        //Sign In User With Firebase
        
        if isSignIn {
        
        FIRAuth.auth()?.signIn(withEmail: email, password: pass, completion: {
            user, error in
            
            if error != nil {
                
                //Something Is Wrong
                
                self.displayAlert(title: "Oh No!", message: "Something Went Wrong. Try Again!")
                
            } else {
                
                //User Found, Go To Tab Bar Controller
                
                self.performSegue(withIdentifier: "tabBarSegue", sender: nil)
                
                print("Logged In!")
            }
        })
            
        }
    }
    
    func registerUser() {
        
        FIRAuth.auth()?.createUser(withEmail: email, password: pass, completion: { (user, error) in
            
            if let e = email {
                
                //User Found Go To Tab Bar Controller
                
                self.performSegue(withIdentifier: "tabBarSegue", sender: nil)
                
                print("Logged In!")
                
            } else {
                
                //Check Error
                
                displayAlert(title: "Oh No!", message: "You Can't Use This! Try Something Else!")
            }
        })
    }
    
    //Display Alert
    
    func displayAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            self.dismiss(animated: true, completion: nil)
            
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
}
