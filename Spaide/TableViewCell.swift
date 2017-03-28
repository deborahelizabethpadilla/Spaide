//
//  TableViewCell.swift
//  Spaide
//
//  Created by Deborah on 3/28/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    //Outlets
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    
    //Get Photos
    
    func initWithPhoto(_ photo: Photo) {
        
        if photo.imageData != nil {
            
            DispatchQueue.main.async {
                
                self.imageView.image = UIImage(data: photo.imageData! as Data)
                self.activityIndicator.stopAnimating()
            }
            
        } else {
            
            downloadImage(photo)
        }
    }
    
    //Download Images
    
    func downloadImage(_ photo: Photo) {
        
        URLSession.shared.dataTask(with: URL(string: photo.imageURL!)!) { (data, response, error) in
            if error == nil {
                
                DispatchQueue.main.async {
                    
                    self.imageView.image = UIImage(data: data! as Data)
                    self.activityIndicator.stopAnimating()
                    self.saveImageDataToCoreData(photo: photo, imageData: data! as NSData)
                }
            }
            
            }
            
            .resume()
    }
    
    //Save Images
    
    func saveImageDataToCoreData(photo: Photo, imageData: NSData) {
        do {
            photo.imageData = imageData
            let delegate = UIApplication.shared.delegate as! AppDelegate
            let stack = delegate.stack
            try stack.saveContext()
        } catch {
            print("Saving Photo imageData Failed")
        }
    }
    
}
