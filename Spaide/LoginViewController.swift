//
//  LoginViewController.swift
//  Spaide
//
//  Created by Deborah on 3/9/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    //Log In Outlets
    
    @IBOutlet var imageView: UIImageView!

    
    //Variables
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set Image View To Circle
        
        imageView.layer.borderWidth = 1
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.cornerRadius = imageView.frame.height / 2
        imageView.clipsToBounds = true

  
    }
    

}
