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
import Firebase

class FormController: UIViewController {
    

    //Outlets
    
    @IBOutlet var profilebackgroundView: UIView!
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var usernameField: AkiraTextField!
    @IBOutlet var descriptionField: AkiraTextField!
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Database Reference
        
        
        
        //Show Saved Data
        
        saveData()
        
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
            data = UIImageJPEGRepresentation(image,0.1)! as NSData
        }
        
        let base64String = data.base64EncodedString(options: [])
        
        let user: NSDictionary = ["name":name!,"description":description!, "photoBase64":base64String]
        
        //Add Firebase Child Node
        
        let profile = Firebase.ref.childByAppendingPath(name!, description!)
        
        //Write Data To Firebase
        
        profile.setValue(user)
        
    }
    
}
