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

class FormController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    //Outlets
    
    @IBOutlet var profilebackgroundView: UIView!
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var titleField: UITextField!
    @IBOutlet var usernameField: UITextField!
    @IBOutlet var descriptionField: UITextField!
    @IBOutlet var imageView: UIImageView!
    
    //Variables
    
    var imagePicker = UIImagePickerController()
    
    //Actions
    
    @IBAction func uploadPhoto(_ sender: Any) {
        
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            print("Picked")
            
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = false
            
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Profile Photo Circle
        
        self.imageView.layer.cornerRadius = imageView.frame.size.width / 2
        self.imageView.clipsToBounds = true
        self.imageView.contentMode = .scaleAspectFill
        
        //Image Picker Delegate
        
        imagePicker.delegate = self
        
        //User Tap To Close Keyboard
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(FormController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
        
        //Close Keyboard With Return Key
        
        self.titleField.delegate = self
        self.usernameField.delegate = self
        self.descriptionField.delegate = self
        
        //Background Of Controller
        
        view.backgroundColor = FlatWhite()
        
        //Set Background View Near Profile Pic
        
        profilebackgroundView.backgroundColor = FlatGreenDark()
        
        //Set Save Button 
        
        saveButton.backgroundColor = FlatGreenDark()
    }
    
    //Profile Photo Subviews
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        imageView.layer.cornerRadius = imageView.frame.width / 2
        imageView.clipsToBounds = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let userlistVC: UserListViewController = segue.destination as! UserListViewController
        
        userlistVC.receivedString = usernameField.text!
        userlistVC.receivedString = titleField.text!
        userlistVC.receivedString = descriptionField.text!
    }
    
    //Image Picker Function
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            imageView.image = pickedImage
        }
        
        dismiss(animated: true, completion: nil)
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
