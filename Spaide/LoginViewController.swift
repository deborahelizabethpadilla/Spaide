//
//  LoginViewController.swift
//  Spaide
//
//  Created by Deborah on 3/9/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    //Log In Outlets
    
    @IBOutlet var signInSelector: UISegmentedControl!
    @IBOutlet var usernameField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var firstnameField: UITextField!
    @IBOutlet var signInLabel: UILabel!
    @IBOutlet var signInButton: UIButton!
    
    //Variables
    
    var isSignIn:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Dismiss Keyboard On Return Key
        
        self.usernameField.delegate = self;
        self.passwordField.delegate = self;
        self.firstnameField.delegate = self;
    }
    
    //Display Alert
    
    func displayAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            
            self.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    //Text Field Functions
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        //Dismiss Keyboard On Tap
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
        
        //Dismiss Keyboard On Return Key
        
        self.view.endEditing(true)
        return false
    }
    
    func dismissKeyboard() {
        
        //Dismiss Keyboard On Tap
        
        view.endEditing(true)
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
        
        if let email = usernameField.text, let password = passwordField.text, let name = firstnameField.text {
            
            if isSignIn {
                
                //Sign In User To Firebase
                
                FIRAuth.auth()?.signIn(withEmail: email, password: password, name: name, completion: { (user, error) in
                    
                    //Check User Isn't Nil
                    
                    if user == user {
                        
                        //Store User To Data Base
                        
                        DataBase.Instance.saveUser(withID: user!.uid, email: email, password: password, name: name)
                        
                        //User Found, Go To Tab Bar
                        
                        self.performSegue(withIdentifier: "goToTabBar", sender: self)
                        
                    } else {
                        
                        //Check Error & Show Alert
                        
                        self.displayAlert(title: "Oh No!", message: "Something Went Wrong. Try Again!")
                    }
                    
                })
                
            } else {
                
                //Register User With Firebase
                
                FIRAuth.auth()?.createUser(withEmail: email, password: password, name: name, completion: { (user, error) in
                    
                    //Check User Isn't Nil
                    
                    if user == user {
                        
                        //Store User To Data Base
                        
                        DataBase.Instance.saveUser(withID: user!.uid, email: email, password: password, name: name)
                        
                        //User Found, Go To Tab Bar
                        
                        self.performSegue(withIdentifier: "goToTabBar", sender: self)
                        
                    } else {
                        
                        //Check Error & Show Alert
                        
                        self.displayAlert(title: "Oh No!", message: "Try Again!")
                    }
                    
                })
            }

        }
        
        
    }
}
