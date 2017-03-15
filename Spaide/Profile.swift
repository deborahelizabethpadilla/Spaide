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


class Profile: UIViewController {
    
    //Outlets
    
    @IBOutlet var profileView: UIImageView!
    @IBOutlet var nameText: UILabel!
    
    //Variables
    
    var loggedInUser = Any?()
    var databaseRef = FIRDatabase.database().reference()
    var storageRef = FIRStorage.storage().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Auth Current User & Profile Data
        
        loggedInUser = FIRAuth.auth()?.currentUser
        
        self.databaseRef.child("user_profiles").child(self.loggedInUser!.uid).observeSingleEvent(of: .Value) { (snapshot: FIRDataSnapshot) in
            
        self.nameText.text = snapshot.value! = ["name"] as? String
            
        }
        
        //Make Profile View A Circle
        
        profileView.layer.cornerRadius = profileView.frame.size.width / 2
        profileView.clipsToBounds = true
        
    }
}

