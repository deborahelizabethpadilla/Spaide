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
import FirebaseAuth
import FBSDKLoginKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    //Variables

    var dict : [String : AnyObject]!
    
    //Outlets
    
    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var registerButton: UIButton!
    @IBOutlet var fbLoginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Alert Title
        
        self.title = ""
        
        //Functions
        
        appDesigns()
        keyboardTap()
        textFunctions()
        
    }
    
    @IBAction func fbLoginButtonAction(_ sender: UIButton) {
        
        FacebookAPI.sharedInstance().facebookLogin()
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
        
        if self.emailField.text == "" || self.passwordField.text == "" {
            
            //Let User Know There Is An Error
            
            displayAlert(title: "Oh Snap!", message: "Please Enter Your Info!")
            
            //Check Internet Connection
            
            if Reachability.isConnectedToNetwork() == true {
                print("Internet Connection OK!")
            } else {
                print("Internet Connection Failed!")
                let alert = UIAlertView(title: "No Internet Connection!", message: "Make Sure Your Device Is Connected To The Internet!", delegate: nil, cancelButtonTitle: "OK")
                alert.show()
            }
            
        } else {
            
            FIRAuth.auth()?.signIn(withEmail: self.emailField.text!, password: self.passwordField.text!) { (user, error) in
                
                if error == nil {
                    
                    //Print If Successfully Logged In
                    
                    print("Successful Log In!")
                    
                    //Go To Tab Bar Controller If Successful
                    
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarController")
                    self.present(vc!, animated: true, completion: nil)
                    
                } else {
                    
                    //Let User Know There Is An Error
                    
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                    
                        }
                
                    }
                
                }
            }
    
    //Register New User
    
    func registerUser() {
        
        if emailField.text == "" {
            
            displayAlert(title: "Oh Snap!", message: "Please Enter Your Info!")
            
        } else {
            
            FIRAuth.auth()?.createUser(withEmail: emailField.text!, password: passwordField.text!) { (user, error) in
                
                if error == nil {
                    
                    print("You Have Successfully Signed Up")
                    
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "tabBarController")
                    self.present(vc!, animated: true, completion: nil)
                    
                } else {
                   
                    self.displayAlert(title: "Oh Snap!", message: "Try Again! Something Happened!")
                }
            }
        }
            
            
        }
        
        //Display Alert
        
        func displayAlert(title: String, message: String) {
            
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                self.dismiss(animated: true, completion: nil)
                
            }))
            
            self.present(alert, animated: true, completion: nil)
            
        }
    
    //Button Designs
    
    func appDesigns() {
        
        //Button Colors & Size
        
        loginButton.backgroundColor = FlatBlack()
        loginButton.layer.cornerRadius = 5
        loginButton.layer.borderWidth = 1
        loginButton.layer.borderColor = UIColor.flatBlack.cgColor
        
        registerButton.backgroundColor = FlatBlack()
        registerButton.layer.cornerRadius = 5
        registerButton.layer.borderWidth = 1
        registerButton.layer.borderColor = UIColor.flatBlack.cgColor
        
        fbLoginButton.layer.cornerRadius = 5
        fbLoginButton.layer.borderWidth = 1
        
        //Set Background Color
        
        view.backgroundColor = FlatWhite()
        
    }
    
    //Keyboard Tap
    
    func keyboardTap() {
        
        //Close Keyboard With Tap
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
        
    }
    
    func textFunctions() {
        
        //Close Keyboard With Return Key
        
        self.emailField.delegate = self
        self.passwordField.delegate = self
    }
    
}
