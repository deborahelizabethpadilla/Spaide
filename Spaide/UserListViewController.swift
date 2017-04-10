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
    
    //Variables
    
    var savedImage:[FacebookPhoto] = []

    //View Did Load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Collection View Delegate
        
        collectionView?.delegate = self
        collectionView?.dataSource = self
        
        //Add Data To Labels
        
        
        //Fetch Photos
        
        
        //Set Background Color
        
        view.backgroundColor = FlatWhite()
        
    }
    
    //Collection View Functions
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! CustomCollectionViewCell
        
        cell.activityIndicator.startAnimating()
        cell.getPhoto(savedImage[indexPath.row])
        return cell
    }
 
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
    }
    
    //Functions
    
    func addDataToLabels() {
        
        
    }
    
}

