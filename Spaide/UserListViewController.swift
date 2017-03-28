//
//  UserListViewController.swift
//  Spaide
//
//  Created by Deborah on 3/28/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import UIKit

class UserListViewController: UICollectionViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
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
        
        
    }
}

