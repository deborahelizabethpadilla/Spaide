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

class ProfileViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    //Outlets

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var pickerView: UIPickerView!
    @IBOutlet var firstNameField: UITextField!
    @IBOutlet var limitationsField: UITextField!
    
    //Variables
    
    let Array = NSArray(array: ["New York", "Los Angeles", "Chicago", "Houston", "Philadelphia"])
    var pickedArray = 0
    let databaseRef = FIRDatabase.database().reference()
    let storageRef = FIRStorage.storage().reference()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Close Keyboard With Return Key
        
        self.firstNameField.delegate = self
        self.limitationsField.delegate = self
        
        //Close Keyboard With Tap
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)

        //Image View Design
        
        self.imageView.layer.cornerRadius = self.imageView.frame.size.width / 2
        self.imageView.clipsToBounds = true
        self.imageView.layer.borderWidth = 3.0
        self.imageView.layer.borderColor = UIColor.flatBlack.cgColor
        
        //Save Button Design
        
        saveButton.backgroundColor = .flatGreen
        saveButton.layer.cornerRadius = 5
        saveButton.layer.borderWidth = 1
        saveButton.layer.borderColor = UIColor.flatGreen.cgColor
        
        //Assign Picker Delegate
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
    }
    
    //Actions
    
    @IBAction func saveButtonAction(_ sender: Any) {
        
        //Picker Choices
        
        let choice : [String : AnyObject] = [:]
        
        if (pickedArray == 0) {

            databaseRef.child("User Posts").childByAutoId().setValue(choice)
            
        } else {
            
            if (pickedArray == 1) {
        
                databaseRef.child("User Posts").childByAutoId().setValue(choice)
                
            } else {
                
                if (pickedArray == 2) {
   
                    databaseRef.child("User Posts").childByAutoId().setValue(choice)
                    
                } else {
                    
                    if (pickedArray == 3) {

                        databaseRef.child("User Posts").childByAutoId().setValue(choice)
                        
                    } else {
                        
                        if (pickedArray == 4) {
            
                            databaseRef.child("User Posts").childByAutoId().setValue(choice)
                            
                        } else {
                            
                            if (pickedArray == 5) {
         
                                databaseRef.child("User Posts").childByAutoId().setValue(choice)
                                
                            } else {
                                
                                if (pickedArray == 0) {
                                    
                                    //Error If Location Isn't Picked
                                    
                                    displayAlert(title: "Oh Snap!", message: "Pick Your Location!")
                                }
                            }
                        }
                    }
                }
            }
        }
        
        infoFields()
    }
    @IBAction func cameraAction(_ sender: Any) {
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePickerController.allowsEditing = false
        self.present(imagePickerController, animated: true, completion: nil)
       
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            imageView.image = image
            
            var data = NSData()
            data = UIImageJPEGRepresentation(imageView.image!, 0.8)!
            
            //Set Upload Path
            
            let filePath = "\(FIRAuth.auth()!.currentUser!.uid)/\("imageView")"
            let metaData = FIRStorageMetadata()
            metaData.contentType = "image/jpg"
            
            self.storageRef.child(filePath).put(data, metadata: metaData, completion: { (metaData, error) in
                
                //Error
                
                if let error = error {
                    
                    print(error.localizedDescription)
                    
                    return
                    
                } else {
                    
                    //Store Download URL
                    
                    let downloadURL = metaData!.downloadURL()!.absoluteString
                    
                    //Store URL At Database
                    
                    self.databaseRef.child("User Posts").child(FIRAuth.auth()?.currentUser!.uid).updateChildValues(["imageView": downloadURL])
                }
                
            })
                
            
        } else {
            
            displayAlert(title: "Oh Snap!", message: "Could Not Get Your Photo!")
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func infoFields() {
        
        if self.firstNameField.text == "" || self.limitationsField.text == "" {
            
            //Error
            
            displayAlert(title: "Oh Snap!", message: "You Need To Enter Your Information!")
            
        } else {
            
            //Save To Firebase
            
            let fields : [String : AnyObject] = [:]
            
            let databaseRef = FIRDatabase.database().reference()
            databaseRef.child("User Posts").childByAutoId().setValue(fields)
        }
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
    
    //Picker View Functions
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return Array[row] as? String
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return Array.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        pickedArray = row
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
