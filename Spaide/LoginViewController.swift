//
//  LoginViewController.swift
//  Spaide
//
//  Created by Deborah on 3/9/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import UIKit
import TextFieldEffects
import ChameleonFramework

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    //Outlets
    
    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set Background Color
        
        view.backgroundColor = flat
  
    }
    

}
