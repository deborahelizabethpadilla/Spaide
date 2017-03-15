//
//  Profile.swift
//  Spaide
//
//  Created by Deborah on 3/13/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage


class Profile: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //Outlets
    
    @IBOutlet var profileView: UIImageView!
    @IBOutlet var nameText: UILabel!
    
    //Variables
    
    var loggedInUser = Any?()
    var databaseRef = FIRDatabase.database().reference()
    var storageRef = FIRStorage.storage().reference()
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Auth Current User & Profile Data
        
        loggedInUser = FIRAuth.auth()?.currentUser
        
        self.databaseRef.child("user_profiles").child(self.loggedInUser!.uid).observeSingleEvent(of: .Value) { (snapshot: FIRDataSnapshot) in
            
        self.nameText.text = snapshot.value! = ["name"] as? String
            
        }
       
        //Make Profile View A Circle
        
        profileView.layer.cornerRadius = profileView.frame.size.width / 2
        profileView.clipsToBounds = true
        
        //Initially User Will Not Have Profile Data
        
        let databaseProfilePic = snapshot.value!["profile_pic"] as! String
        
        let data = NSData(contentsOf: URL(string: databaseProfilePic)!)
        
        self.setProfilePicture(self.profilePicture, imageToSet: UIImage(data: data!)!)
        
    }
    
    //Set Profile Picture
    
    internal func setProfilePicture(profileView: UIImage, imageToGet: UIImage) {
        
        self.profileView.layer.masksToBounds = true
        profileView.layer.cornerRadius = 10.0
        profileView.layer.borderColor = UIColor.white.cgColor
        profileView.image = imageToSet
    }
    @IBAction func tapProfilePicture(_ sender: UITapGestureRecognizer) {
        
        //Create Action Sheet For Gallery & Camera
        
        let myActionSheet = UIAlertController(title: "Profile Picture", message: "Select", preferedStyle: UIAlertControllerStyle.actionSheet)
        
        let viewPicture = UIAlertAction(title: "View Picture", style: UIAlertActionStyle.default) { (action) in
            
            let imageView = sender.view as! UIImageView
            
            let newImageView = UIImageView(image: imageView.image)
            
            newImageView.frame = self.view.frame
            newImageView.backgroundColor = UIColor.black
            newImageView.contentMode = .scaleAspectFit
            newImageView.isUserInteractionEnabled = true
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissFullScreenImage))
            
            newImageView.addGestureRecognizer(tap)
            self.view.addSubview(newImageView)
            
        }
        
        //Photo Gallery
        
        let photoGallery = UIAlertAction(title: "Photos", style: UIAlertActionStyle.default) { (action) in
            
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.savedPhotosAlbum) {
                
                self.imagePicker.delegate = self
                self.imagePicker.sourceType = UIImagePickerControllerSourceType.savedPhotosAlbum
                self.imagePicker.allowsEditing = true
                self.present(self, animated: true, completion: nil)
            }
        }
        
        //Camera
        
        let camera = UIAlertAction(title: "Camera", style: UIAlertActionStyle.default) { (action) in
            
            self.imagePicker.delegate = self
            self.imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            self.imagePicker.allowsEditing = true
            
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        
        
        
        }

    }
    
    func dismissFullScreenImage(sender: UITapGestureRecognizer) {
        
        //Remove Larger Image From View
        
        sender.view?.removeFromSuperview()
        
    }


