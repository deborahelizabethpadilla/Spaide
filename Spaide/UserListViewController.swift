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
    
    var receivedString:String = ""
    
    
    //View Did Load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Collection View Delegate
        
        collectionView?.delegate = self
        collectionView?.dataSource = self
        
        //Set Background Color
        
        view.backgroundColor = FlatGreenDark()
        
    }
    
    //Collection View Functions
 
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "userCell", for: indexPath) as! CustomCollectionViewCell
        
        cell.nameLabel.text = receivedString
        cell.titleLabel.text = receivedString
        cell.descriptionLabel.text = receivedString
        
        return cell
    }
    
    
}

