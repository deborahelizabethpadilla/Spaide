//
//  UserTableViewController.swift
//  Spaide
//
//  Created by Deborah on 4/26/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import UIKit
import ChameleonFramework
import Firebase
import FirebaseDatabase

struct UserStruct {
    
    var firstName: String?
    var city: String?
    var limits: String?
}

class UserTableViewController: UITableViewController {

    //Variables
    
    var refUsers: FIRDatabaseReference!
    var refHandle: UInt!
    var userInfo = [UserStruct]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let databaseReference = FIRDatabase.database().reference()
        
        databaseReference.child("Profile").queryOrderedByKey().observe(.childAdded, with: { (snapshot) in
            
            var snapshotValue = snapshot.value as? NSDictionary
            
            let firstName = snapshotValue!["firstName"] as? String
            snapshotValue = snapshot.value as? NSDictionary
            
            let city = snapshotValue!["city"] as? String
            snapshotValue = snapshot.value as? NSDictionary
            
            let limits = snapshotValue!["limits"] as? String
            snapshotValue = snapshot.value as? NSDictionary
            
            self.userInfo.insert(UserStruct(firstName: firstName, city: city, limits: limits), at: self.userInfo.count)
            self.tableView.reloadData()
            
        })
        
        print(userInfo)
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return userInfo.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Set Cell Contents
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! CustomTableViewCell
        
        cell.firstNameLabel.text = userInfo[indexPath.row].firstName
        cell.locationLabel.text = userInfo[indexPath.row].city
        cell.limitationsLabel.text = userInfo[indexPath.row].limits
        
        return cell
    
    }

} //End Of Class
