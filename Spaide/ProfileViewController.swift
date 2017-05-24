//
//  ProfileViewController.swift
//  Spaide
//
//  Created by Deborah on 4/26/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import SVProgressHUD

class ProfileViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //Variables
    
    var refUsers: DatabaseReference!
    
    //Outlets

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var firstNameField: UITextField!
    @IBOutlet var limitationsField: UITextField!
    @IBOutlet var citystateField: UITextField!
    
    //Actions

    @IBAction func saveButton(_ sender: Any) {
        
        addUserData()
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Close Keyboard With Return Key
        
        self.firstNameField.delegate = self
        self.limitationsField.delegate = self
        self.citystateField.delegate = self
        
        //Close Keyboard With Tap
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
        
        //Firebase
        
        refUsers = Database.database().reference().child("Profile")
        
        //Save Button Design
        
        saveButton.layer.cornerRadius = 10
        saveButton.clipsToBounds = true

    }
    
    //Close Keyboard With Tap
    
    func dismissKeyboard() {
        
        //Close On Tap
        
        view.endEditing(true)
    }
    
    //Close Keyboard With Return Key
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        //Close On Return
        
        self.view.endEditing(true)
        return false
    }
    
    //Add User Data
    

    func addUserData() {
        
        SVProgressHUD.show(withStatus: "Posting Information...")
        
        if success {
            
        SVProgressHUD.dismiss()
        
        let key = refUsers?.childByAutoId().key
        
        let user = ["id": key!, "firstName": firstNameField.text! as String, "limits": limitationsField.text! as String, "city": citystateField.text! as String]
        
        refUsers.child(key!).setValue(user)
            
        } else {
            
            SVProgressHUD.showError(withStatus: "Network Error! Could Not Post Information!")
        }
    
    
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentCharacterCount = limitationsField.text?.characters.count ?? 0
        if (range.length + range.location > currentCharacterCount){
            return false
        }
        let newLength = currentCharacterCount + string.characters.count - range.length
        return newLength <= 45
    }
        
} // End Class
