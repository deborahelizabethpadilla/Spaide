//
//  LoginViewController.swift
//  Spaide
//
//  Created by Deborah on 3/9/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import UIKit
import ChameleonFramework

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    //Outlets
    
    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Close Keyboard With Return Key
        
        self.emailField.delegate = self
        self.passwordField.delegate = self
        
        //Close Keyboard With Tap
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
        
        //Set Background Color
        
        view.backgroundColor = FlatBlack()
        
  
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
}
