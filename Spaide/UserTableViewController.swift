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
    var userInfo = [UserInfo]()
    var indicator = Indicator()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
      //Load Saved Info
        
      ref = FIRDatabase.database().reference()
        
      //Activity Indicator
        
      indicator.center = self.view.center
      self.view.addSubview(indicator)
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Set Cell Contents
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! CustomTableViewCell
        
        cell.firstNameLabel.text = userInfo[indexPath.row].firstName
        cell.locationLabel.text = userInfo[indexPath.row].city
        cell.limitationsLabel.text = userInfo[indexPath.row].limits
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return userInfo.count
    }

} //End Of Class
