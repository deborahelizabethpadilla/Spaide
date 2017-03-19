//
//  LoginViewController.swift
//  Spaide
//
//  Created by Deborah on 3/9/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import UIKit

class LoginViewController: UITableViewController,UITextFieldDelegate {
    
    //Outlets
    
    @IBOutlet var imageView: UIImageView!
    
    //Variables
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       //Profile Photo Circular
        
       imageView.layer.borderWidth = 1
       imageView.layer.masksToBounds = false
       imageView.layer.borderColor = UIColor.black.cgColor
       imageView.layer.cornerRadius = imageView.frame.height / 2
       imageView.clipsToBounds = true

  
    }
    

}
