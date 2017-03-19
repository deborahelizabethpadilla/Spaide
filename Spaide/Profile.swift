//
//  Profile.swift
//  Spaide
//
//  Created by Deborah on 3/13/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import UIKit

class Profile: UITableViewController, UIViewController {
    
    //Outlets
    
    @IBOutlet weak var imageView: UIImageView!
       
    //Variables
    
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Profile Photo Circular
        
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        imageView.layer.borderWidth = 1
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.cornerRadius = imageView.frame.height / 2
        imageView.clipsToBounds = true

    
        
    }
        
}
