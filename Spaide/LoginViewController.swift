//
//  LoginViewController.swift
//  Spaide
//
//  Created by Deborah on 3/9/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    //Log In Outlets
    
    @IBOutlet var signInSelector: UISegmentedControl!
    @IBOutlet var usernameField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var signInLabel: UILabel!
    @IBOutlet var signInButton: UIButton!
    
    //Variables
    
    var isSignIn:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    //Log In Actions
    
    
    @IBAction func signInSelector(_ sender: Any) {
        
        //Flip The Boolean
        
        isSignIn = !isSignIn
        
        //Check Bool & Set Button/Labels
        
        if isSignIn {
            
            signInLabel.text = "Sign In"
            signInButton.setTitle("Sign In", for: .normal)
            
        } else {
            
            signInLabel.text = "Register"
            signInButton.setTitle("Register", for: .normal)
        }
        
    }
    
    @IBAction func signInAction(_ sender: Any) {
        
        //Validate If E-mail And Password Are Correct
        
        if let email = usernameField.text, let password = passwordField.text {
            
            if isSignIn {
                
                //Sign In User To Firebase
                
                FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
                    
                    //Check User Isn't Nil
                    if let u = user {
                        
                        //User Found, Go To Tab Bar
                        
                        self.performSegue(withIdentifier: "goToTabBar", sender: self)
                        
                    } else {
                        
                        //Check Error & Show Alert
                    }
                    
                })
                
            } else {
                
                //Register User With Firebase
                
                FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
                    
                    //Check User Isn't Nil
                    
                    if let u = user {
                        
                        //User Found, Go To Tab Bar
                        
                        self.performSegue(withIdentifier: "goToTabBar", sender: self)
                        
                    } else {
                        
                        //Check Error & Show Alert
                    }
                    
                })
            }

        }
        
        
    }
}
