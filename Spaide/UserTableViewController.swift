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

struct postStruct {
    
    let firstName : String?
    let city : String?
    let limits : String?
}

class UserTableViewController: UITableViewController {

    //Variables
    
    var refUsers: FIRDatabaseReference!
    var databaseRef = FIRDatabase.database().reference()
    var refHandle: UInt!
    var userInfo = [UserInfo]()
    var posts = [postStruct]()
    var dictionary = [[String:AnyObject]]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        databaseRef.child("Profile").queryOrderedByKey().observe(.childAdded, with: { (snapshot) in
            
            let snapshotValue = snapshot.value as? NSDictionary
            
            let firstName = snapshotValue?["firstName"] as! String
            
            let city = snapshotValue?["city"] as! String
            
            let limits = snapshotValue?["limitations"] as! String
            
            self.posts.insert(postStruct(firstName: firstName, city: city, limits: limits) , at: 0)
            
            self.tableView.reloadData()
        })
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Set Cell Contents
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! CustomTableViewCell
        
        cell.firstNameLabel.text = posts[indexPath.row].firstName
        cell.locationLabel.text = posts[indexPath.row].city
        cell.limitationsLabel.text = posts[indexPath.row].limits
        
       return cell
    
    }

} //End Of Class
