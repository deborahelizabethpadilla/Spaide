//
//  FormController.swift
//  Spaide
//
//  Created by Deborah on 3/28/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import UIKit
import ChameleonFramework
import TextFieldEffects
import FirebaseDatabase
import Firebase

class FormController: UIViewController {
    
    //Firebase Database Reference
    
    var ref: FIRDatabaseReference!

    //Outlets
    
    @IBOutlet var profilebackgroundView: UIView!
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var titleField: AkiraTextField!
    @IBOutlet var usernameField: AkiraTextField!
    @IBOutlet var descriptionField: AkiraTextField!
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Database Reference
        
        configureDatabase()
        
        //Set Background To View Near Profile Pic
        
        profilebackgroundView.backgroundColor = FlatWatermelonDark()
        
        //Set Save Button 
        
        saveButton.backgroundColor = FlatWatermelonDark()
    }
    
    
    //Firebase Database Reference
    
    func configureDatabase() {
        
        //Get Firebase Database Reference
        
        ref = FIRDatabase.database().reference()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let userlistVC: UserListViewController = segue.destination as! UserListViewController
        
        userlistVC.receivedString = usernameField.text!
        userlistVC.receivedString = titleField.text!
        userlistVC.receivedString = descriptionField.text!
    }
}
