//
//  CustomCollectionViewCell.swift
//  Spaide
//
//  Created by Deborah on 3/28/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import UIKit
import Firebase

class CustomCollectionViewCell: UICollectionViewCell {
    
    //Outlets
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var chatButton: UIButton!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    //Get Image
    
    func getPhoto() {
        
        DispatchQueue.main.async {
            
            self.imageView.image =
            self.activityIndicator.stopAnimating()
            
        } else {
            
            downloadImage()
        }
        
    }
    
    //Download Image
    
    func downloadImage() {
        
        
    
    }
    
    //Save Image To Firebase
    
    func saveImageToFirebase() {
        
   

    }
    
    //Get Data
    
    func getData() {
        
        
    }
    
    //Download Data
    
    func downloadData() {
        
    }
    
    //Save Data To Firebase
    
    func saveDataToFirebase() {
        
        
    }
    
}
