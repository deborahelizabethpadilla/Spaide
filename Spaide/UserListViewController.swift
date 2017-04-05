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
    
    @IBOutlet var collectionView: UICollectionView!
    
    //Database Reference
    
    var ref: FIRDatabaseReference!
    
    //User Profile Info
    
    struct userObject {
        
        var profilePicture: UIImage
        var name: String
        var description: String
        var cityState: String
    }
    
    //Fill Objects
    
    var userArray: NSArray = ["profilePicture", "name", "description", "cityState"]
    
    //View Did Load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Configure Database
        
        configureDatabase()
        
        //Load User Info
        
        getData()
        
        //Collection View Delegate
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        //Set Background Color
        
        view.backgroundColor = FlatGreenDark()
        
    }
    
    //Get Data Function
    
    func getData() {
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        ref.observe(.value, with: { snapshot in
            
            var tempItems = [NSDictionary]()
            
            for item in snapshot.children {
                
                let child = item as! FIRDataSnapshot
                let dict = child.value as! NSDictionary
                tempItems.append(dict)
                
            }
            
            self.collectionView.reloadData()
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        })
    }
    
    
    //Collection View Functions
 
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return userArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "userCell", for: indexPath) as! CustomCollectionViewCell
        
        cell.nameLabel.text = (userArray[indexPath.item] as AnyObject).name
        cell.userInfo.text = (userArray[indexPath.item] as AnyObject).description
        
        return cell
    }
    
    //Database Reference
    
    func configureDatabase() {
        
        //Get FIRDatabaseReference
        
        ref = FIRDatabase.database().reference()
    }
}

