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

class UserTableViewController: UITableViewController {

    //Variables
    
    var refUsers: FIRDatabaseReference!
    var databaseRef = FIRDatabase.database().reference()
    var refHandle: UInt!
    var userInfo = [UserInfo]()
    var infoData = [String: Any]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        refUsers = FIRDatabase.database().reference()
        
        getUserData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return userInfo.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Set Cell Contents
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! CustomTableViewCell
        
        let userPostRef = self.databaseRef.child("Profile")
        userPostRef.observe(.childAdded, with: { (snapshot) in
            
            if (snapshot.value as? NSDictionary) != nil {
                
                let myPost = UserInfo()
                self.userInfo.insert(myPost, at:0)
                
                cell.firstNameLabel.text = self.userInfo[indexPath.row].firstName
                cell.locationLabel.text = self.userInfo[indexPath.row].city
                cell.limitationsLabel.text = self.userInfo[indexPath.row].limits
            }
            
        })
        
       return cell
    
    }
    
    func getUserData() {
        
        refHandle = refUsers.child("Profile").observe(.childAdded, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String : AnyObject] {
                
                print(dictionary)
                
                let user = UserInfo()
                
                user.setValuesForKeys(dictionary)
                self.userInfo.append(user)
                
                DispatchQueue.main.async {
                    
                    self.tableView.reloadData()
                }
            }
        })
    }

} //End Of Class
