//
//  UserListViewController.swift
//  Spaide
//
//  Created by Deborah on 3/28/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import UIKit
import ChameleonFramework

class UserListViewController: UICollectionViewController, UICollectionViewDelegate,UICollectionViewDataSource {
    
    //Database Reference
    
    let firebase = Firebase(url:"https://spaide-2cc40.firebaseio.com/profiles")
    
    //User Info
    
    struct userObject {
        
        var profilePicture: UIImage
        var name: String
        var description: String
    }
    
    //Fill Objects
    
    var userArray: [userObject] = []
    
    //Outlets
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var chatButtonOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Load User Info
        
        getData()
        
        //Collection View Delegate
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        //Set Background Color
        
        view.backgroundColor = FlatGreenDark()
        
        //Chat Button Color
        
        chatButtonOutlet.backgroundColor = FlatWatermelonDark()
        
    }
    
    //Functions
    
    func getData() {
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        Firebase.observeEventType(.Value, withBlock: { snapshot in
            var tempItems = [NSDictionary]()
            
            for item in snapshot.children {
                
                let child = item as! FDataSnapshot
                let dict = child.value as! NSDictionary
                tempItems.append(dict)
            }
            
            self.items = tempItems
            self.tableView.reloadData()
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        })
    }
    
    //Collection View Functions
 
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return userArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "userCell", for: indexPath) as! CustomCollectionViewCell
        
        cell.nameLabel.text = userArray[indexPath.item].name
        cell.imageView.image = userArray[indexPath.item].profilePicture
        cell.userInfo.text = userArray[indexPath.item].description
        
        return cell
    }
}

