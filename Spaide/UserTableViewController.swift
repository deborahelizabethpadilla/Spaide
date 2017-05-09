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
    var refHandle: UInt!
    var userList = [UsersInfo]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        refUsers = FIRDatabase.database().reference()
        
        getData()
    }
    
    func getData() {
        
        self.refUsers.observe(FIRDataEventType.childAdded) { (snapshot: FIRDataSnapshot) in
            
            let firstName = snapshot.value(forKey: "firstName") as! String
            let city = snapshot.value(forKey: "city") as! String
            let limits = snapshot.value(forKey: "limits") as! String
            
            print(firstName, city, limits)
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return userList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Set Cell Contents
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! CustomTableViewCell
        
        cell.firstNameLabel.text = userList[indexPath.row].firstName
        cell.locationLabel.text = userList[indexPath.row].city
        cell.limitationsLabel.text = userList[indexPath.row].limits
        
        return cell
    
    }

} //End Of Class
