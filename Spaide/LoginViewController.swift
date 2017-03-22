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
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var seekingButton: UIButton!
    @IBOutlet var provideButton: UIButton!
    
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
        
        seekingButton.backgroundColor = .flatWatermelonDark
        seekingButton.layer.cornerRadius = 5
        seekingButton.layer.borderWidth = 1
        seekingButton.layer.borderColor = UIColor.flatWatermelonDark.cgColor
        
        provideButton.backgroundColor = .flatWatermelonDark
        provideButton.layer.cornerRadius = 5
        provideButton.layer.borderWidth = 1
        provideButton.layer.borderColor = UIColor.flatWatermelonDark.cgColor
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
