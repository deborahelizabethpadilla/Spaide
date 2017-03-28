//
//  PostController.swift
//  Spaide
//
//  Created by Deborah on 3/22/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import UIKit
import ChameleonFramework
import Firebase
import FirebaseDatabase

class PostController: UITableViewController {
    
    //Outlets
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set Background Color
        
        view.backgroundColor = FlatGreenDark()
        
    }
    
    //Core Data
    
    func getCoreDataStack() -> CoreDataStack {
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        return delegate.stack
    }
    
    //Fetch Results
    
    func getFetchedResultsController() -> NSFetchedResultsController<NSFetchRequestResult> {
        
        let stack = getCoreDataStack()
        
        let fr = NSFetchRequest<NSFetchRequestResult>(entityName: "Pin")
        fr.sortDescriptors = []
        
        return NSFetchedResultsController(fetchRequest: fr, managedObjectContext: stack.context, sectionNameKeyPath: nil, cacheName: nil)
    }
}

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
