//
//  ProfileViewController.swift
//  Spaide
//
//  Created by Deborah on 4/26/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import UIKit
import ChameleonFramework
import Firebase
import FirebaseDatabase

class ProfileViewController: UIViewController {
    
    //Variables
    
    let refUsers = FIRDatabaseReference

    //Outlets

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var firstNameField: UITextField!
    @IBOutlet var limitationsField: UITextField!
    @IBOutlet var citystateField: UITextField!

    @IBAction func saveButton(_ sender: Any) {
        
        addUserData()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
     //Firebase
        
     refUsers = FIRDatabase.database().reference().child("Profile")

    }
    
    func addUserData() {
        
        let key = refUsers.childByAutoId().key
        
        let user = ["id": key, "firstName": firstNameField.text! as String, "limits": limitationsField.text! as String, "city": citystateField.text! as String]
        
        refUsers.child(key).setValue(user)
        
    }
  
}
            
