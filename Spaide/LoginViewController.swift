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
        
        let colors:[UIColor] = [
            UIColor.flatGreenDark,
            UIColor.flatWhite
        ]
        view.backgroundColor = GradientColor(.topToBottom, frame: view.frame, colors: colors)
        
        //Button Colors
        
        loginButton.backgroundColor = .flatGreenDark
        loginButton.layer.cornerRadius = 5
        loginButton.layer.borderWidth = 1
        loginButton.layer.borderColor = UIColor.flatGreenDark.cgColor
        
        seekingButton.backgroundColor = .flatGreenDark
        seekingButton.layer.cornerRadius = 5
        seekingButton.layer.borderWidth = 1
        seekingButton.layer.borderColor = UIColor.flatGreenDark.cgColor
        
        provideButton.backgroundColor = .flatGreenDark
        provideButton.layer.cornerRadius = 5
        provideButton.layer.borderWidth = 1
        provideButton.layer.borderColor = UIColor.flatGreenDark.cgColor
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
