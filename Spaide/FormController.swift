//
//  FormController.swift
//  Spaide
//
//  Created by Deborah on 3/28/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import UIKit
import ChameleonFramework
import Firebase
import FirebaseDatabase
import FirebaseStorage

class FormController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    //Firebase Storage Reference
    
    let storageRef = FIRStorage.storage().reference()
    
    //Firebase Database Reference
    
    let databaseRef = FIRDatabase.database().reference()

    //Outlets
    
    @IBOutlet var profilebackgroundView: UIView!
    @IBOutlet var titleField: UITextField!
    @IBOutlet var usernameField: UITextField!
    @IBOutlet var descriptionField: UITextField!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var saveButton: UIButton!
    
    //Actions
    
    @IBAction func saveButton(_ sender: Any) {
        
        if self.titleField.text == "" || self.descriptionField.text == "" || self.usernameField.text == "" {
            
            //Alert User
            
            displayAlert(title: "Oh No!", message: "Please Enter Your Information!")
            
        } else {
            
            performSegue(withIdentifier: "userList", sender: self)
        }
        
    }
    
    //View Did Load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Profile Photo Circle
        
        self.imageView.layer.cornerRadius = imageView.frame.size.width / 2
        self.imageView.clipsToBounds = true
        self.imageView.contentMode = .scaleAspectFill
        self.imageView.layer.borderWidth = 4.0
        self.imageView.layer.borderColor = (FlatBlack() as! CGColor)
        
        //User Tap To Close Keyboard
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(FormController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
        
        //Close Keyboard With Return Key
        
        self.titleField.delegate = self
        self.usernameField.delegate = self
        self.descriptionField.delegate = self
        
        //Background Of Controller
        
        view.backgroundColor = FlatWhite()
        
        //Set Save Button 
        
        saveButton.backgroundColor = FlatGreenDark()
    }
    
    //Profile Photo Subviews
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        imageView.layer.cornerRadius = imageView.frame.width / 2
        imageView.clipsToBounds = true
    }

    //Close Keyboard Functions
    
    func dismissKeyboard() {
       
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        
        return false
    }
    
    //Display Alert
    
    func displayAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            self.dismiss(animated: true, completion: nil)
            
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }

}
