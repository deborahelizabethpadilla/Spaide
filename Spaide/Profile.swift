//
//  Profile.swift
//  Spaide
//
//  Created by Deborah on 3/13/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage


class Profile: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //Outlets
    
    @IBOutlet var profileView: UIImageView!
    @IBOutlet var nameText: UILabel!
    
    //Variables
    
    var loggedInUser = FIRAuth.auth()?.currentUser
    var databaseRef = FIRDatabase.database().reference()
    var storageRef = FIRStorage.storage().reference()
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Auth Current User & Profile Data

    
        
    }
    
    //Set Profile Picture
    
    
    @IBAction func tapProfilePicture(_ sender: UITapGestureRecognizer) {
        
        //Create Action Sheet For Gallery & Camera
        
}

}
