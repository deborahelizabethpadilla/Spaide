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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Append By Passing Through Info To Array
        
        
        
        //Collection View Delegate
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        //Set Background Color
        
        view.backgroundColor = FlatGreenDark()
        
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

