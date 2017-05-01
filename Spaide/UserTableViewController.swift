//
//  UserTableViewController.swift
//  Spaide
//
//  Created by Deborah on 4/26/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

struct postStruct {
    
    let firstName = String()
    let limitations = String()
    let location = String()
}

class UserTableViewController: UITableViewController {
    
    //Variables

    var users:User = userData
    
    let posts = [postStruct]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let databaseRef = FIRDatabase.database().reference()
        
        databaseRef.child("User Posts").queryOrderedByKey().observe(.childAdded, with: {
            snapshot in
            
            
            
        
        }
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 0
    }
    
    //Fill Cell
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell")
        
        let firstNameLabel = cell?.viewWithTag(1) as! UILabel
        firstNameLabel.text = posts[indexPath.row].firstName
        
        let locationLabel = cell?.viewWithTag(2) as! UILabel
        locationLabel.text = posts[indexPath.row].location
        
        let limitationsLabel = cell?.viewWithTag(3) as! UILabel
        limitationsLabel.text = posts[indexPath.row].limitations
        
        
        return cell!
    }
    
    func fetchUsers() {
        
    }

}
