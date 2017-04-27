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

class ProfileViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    //Outlets

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var pickerView: UIPickerView!
    @IBOutlet var firstNameField: UITextField!
    @IBOutlet var limitationsField: UITextField!
    
    //Variables
    
    var Array = ["New York", "Chicago", "Los Angeles", "Miami", "Atlanta", "Philadelphia", "Stamford", "Dallas", "Las Vegas", "Seattle", "Austin", "Nashville"]
    
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
    
    //Post
    
    func post() {
        
        let firstName = firstNameField
        let limitations = limitationsField
        let profilePic = imageView
        let pickerChoice = UIPickerViewDataSource.self
        
        let post : [String : AnyObject] = [firstName: "", limitations: "", profilePic: UIImage, pickerChoice: ""]
        
        let databaseRef = FIRDatabase.database().reference()
        
        databaseRef.child("User Posts").childByAutoId().setValue(post)
        
    }
    
    //Actions
    
    @IBAction func saveButtonAction(_ sender: Any) {
        
        post()
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
        
        return Array[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return Array.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }

}
