//
//  InputController.swift
//  Spaide
//
//  Created by Deborah on 3/22/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import UIKit
import ChameleonFramework
import Firebase

class InputController: UIViewController {
    
    //Outlets
    
    @IBOutlet var postLabel: UIButton!
    @IBOutlet var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Variables
        
        _ = FIRDatabase.database().reference()
        let storage = FIRStorage.storage().reference()
        let tempImageRef = storage.child("tmpDir/tmpImage.jpg")
        
        /*
        
        let image = UIImage(named: "firebaseImage.jpg")
        let metaData = FIRStorageMetadata()
        metaData.contentType = "image/jpeg"
        
        tempImageRef.put(UIImageJPEGRepresentation(image!, 0.0)!, metadata: metaData) { (data, error) in
            if error == nil {
                
                print("Upload Success!")
            } else {
                
                print(error?.localizedDescription)
            }
        }
        
        */
        
        tempImageRef.data(withMaxSize: Int64(1*1000*1000)) { (data, error) in
            
            if error == nil {
                
                print(data!)
                
                self.imageView.image = UIImage(data: data!)
                
            } else {
                
                print(error?.localizedDescription as Any)
            }
        }
        
        //Set Background
        
        view.backgroundColor = FlatGreenDark()
        
        //Button Colors & Size
        
        postLabel.backgroundColor = .flatWatermelonDark
        postLabel.layer.cornerRadius = 5
        postLabel.layer.borderWidth = 1
        postLabel.layer.borderColor = UIColor.flatWatermelonDark.cgColor
    
    }
}
