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
    var userInfo = [UserInfo]()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return userInfo.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Set Cell Contents
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! CustomTableViewCell
        
        let user = userInfo[indexPath.row]
        
        cell.firstNameLabel.text = user.firstName
        cell.limitationsLabel.text = user.limits
        cell.locationLabel.text = user.city
        
        cell.imageView?.image = UIImage(named: <#T##String#>)
        
        
        
        return cell
    }

} //End Of Class
