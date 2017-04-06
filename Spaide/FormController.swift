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

class FormController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    //Outlets
    
    @IBOutlet var profilebackgroundView: UIView!
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var titleField: AkiraTextField!
    @IBOutlet var usernameField: AkiraTextField!
    @IBOutlet var descriptionField: AkiraTextField!
    @IBOutlet var imageView: UIImageView!
    
    //Variables
    
    var imagePicker = UIImagePickerController()
    
    //Actions
    
    @IBAction func uploadPhoto(_ sender: Any) {
        
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            print("Picked")
            
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = false
            
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //User Tap To Close Keyboard
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(FormController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
        
        //Close Keyboard With Return Key
        
        self.titleField.delegate = self
        self.usernameField.delegate = self
        self.descriptionField.delegate = self
        
        //Set Background To View Near Profile Pic
        
        profilebackgroundView.backgroundColor = FlatWatermelonDark()
        
        //Set Save Button 
        
        saveButton.backgroundColor = FlatWatermelonDark()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let userlistVC: UserListViewController = segue.destination as! UserListViewController
        
        userlistVC.receivedString = usernameField.text!
        userlistVC.receivedString = titleField.text!
        userlistVC.receivedString = descriptionField.text!
    }
    
    //Image Picker Function
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!) {
        self.dismiss(animated: true, completion: { () -> Void in
            
        })
        
        imageView.image = image
        
    }

    //Close Keyboard Functions
    
    func dismissKeyboard() {
       
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        
        return false
    }
}
