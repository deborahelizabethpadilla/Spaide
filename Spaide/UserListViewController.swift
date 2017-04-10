//
//  UserListViewController.swift
//  Spaide
//
//  Created by Deborah on 3/28/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import UIKit
import ChameleonFramework
import FirebaseDatabase
import Firebase

class UserListViewController: UICollectionViewController {
    
    //Outlets
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!

    //View Did Load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Collection View Delegate
        
        collectionView?.delegate = self
        collectionView?.dataSource = self
        
        //Add Labels
        
        
        //Fetch Photos
        
        
        //Set Background Color
        
        view.backgroundColor = FlatWhite()
        
    }
    
    //Collection View Functions
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
    }
 
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
    }
    
    //Functions
    
    func addLabels() {
        
        
    }
    
}

