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
    var dictionary: [String:AnyObject]?

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
        
        cell.firstNameLabel.text = self.dictionary?["firstName"] as? String
        cell.locationLabel.text = self.dictionary?["city"] as? String
        cell.limitationsLabel.text = self.dictionary?["limits"] as? String
        
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
