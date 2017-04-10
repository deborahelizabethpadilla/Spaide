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
    
    @IBAction func saveButton(_ sender: Any) {
        
        if self.titleField.text == "" || self.descriptionField.text == "" || self.usernameField.text == "" {
            
            //Alert User
            
            displayAlert(title: "Oh No!", message: "Please Enter Your Information!")
            
        } else {
            
            performSegue(withIdentifier: "userList", sender: self)
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Profile Photo Circle
        
        self.imageView.layer.cornerRadius = imageView.frame.size.width / 2
        self.imageView.clipsToBounds = true
        self.imageView.contentMode = .scaleAspectFill
        self.imageView.layer.borderWidth = 4.0
        self.imageView.layer.borderColor = (FlatBlack() as! CGColor)
        
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
        
        //Set Save Button 
        
        saveButton.backgroundColor = FlatGreenDark()
    }
    
    //Profile Photo Subviews
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        imageView.layer.cornerRadius = imageView.frame.width / 2
        imageView.clipsToBounds = true
    }
    
    //Image Picker Function
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            //Pick Image
            
            imageView.image = pickedImage
            
            dismiss(animated: true, completion: nil)
            
            var data = NSData()
            
            data = UIImageJPEGRepresentation(imageView.image!, 0.8)! as NSData
            
            //Set Upload Path
            
            let filePath = "\(FIRAuth.auth()!.currentUser!.uid)/\("imageView")"
            let metaData = FIRStorageMetadata()
            metaData.contentType = "image/jpg"
            self.storageRef.child(filePath).put(data as Data, metadata: metaData) {
                
                (metaData, error) in
                
                if let error = error {
                    
                    print(error.localizedDescription)
                    
                    return
                    
                } else {
                    
                    //Store Download URL
                    
                    let downloadURL = metaData!.downloadURL()!.absoluteString
                    
                    //Store At Database
                    
                    self.databaseRef.child("users").child(FIRAuth.auth()!.currentUser!.uid).updateChildValues(["imageView": downloadURL])
                }
                
            }
        
        }
        
        //Get Photo Back
        
        databaseRef.child("users").child(userID!).observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            
            //Check If User Has Photo
            
            if snapshot.hasChild("imageView") {
                
                //Set Image Location
                
                let filePath = "\(userID!)/\("imageView")"
                
                //Assuming Size Of Photo, Otherwise Change
                
                self.storageRef.child(filePath).dataWithMaxSize(10*1024*1024, completion: { (data, error) in
                    
                    let imageView = UIImage(data: data!)
                    self.imageView.image = imageView
                })
            }
        })
        
        
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
