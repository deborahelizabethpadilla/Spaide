//
//  FormController.swift
//  Spaide
//
//  Created by Deborah on 3/28/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import UIKit
import ChameleonFramework
import FirebaseDatabase

class FormController: UIViewController, FIRDatabaseQuery {
    
    //Variables
    
    var ref:FirebaseDatabaseReference?
    
    //Outlets
    
    @IBOutlet var profilebackgroundView: UIView!
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var usernameField: AkiraTextField!
    @IBOutlet var descriptionField: AkiraTextField!
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Database Reference
        
        let firebase = Firebase(url:"https://spaide-2cc40.firebaseio.com/profiles")
        
        //Set Background To View Near Profile Pic
        
        profilebackgroundView.backgroundColor = FlatWatermelonDark()
        
        //Set Save Button 
        
        saveButton.backgroundColor = FlatWatermelonDark()
    }
    
    //Actions
    
    @IBAction func saveButtonAction(_ sender: Any) {
        
        saveData()
        
    }
    
    func saveData() {
        
        //Data To Save
        
        let name = usernameField.text
        var data: NSData = NSData()
        
        let description = descriptionField.text
        var data2: NSData = NSData()
        
        if let image = imageView.image {
            data = UIImageJPEGRepresentation(image,0.1)!
        }
        
        let base64String = data.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)
        
        let user: NSDictionary = ["name":name!,"description":description!, "photoBase64":base64String]
        
        //Add Firebase Child Node
        
        let profile = firebase.ref.childByAppendingPath(name!, description!)
        
        //Write Data To Firebase
        
        profile.setValue(user)
        
    }
    
}
