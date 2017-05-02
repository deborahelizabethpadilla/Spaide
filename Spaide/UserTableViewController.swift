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

class UserTableViewController: UITableViewController {

    //Variables
    
    var ref: FIRDatabaseReference!
    var userInfo = [UserInfo]()
    var refHandle: UInt!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
      //Load Saved Info
        
      ref = FIRDatabase.database().reference()
      fetchUsersInfo()
        
    }
    
    //Will Appear
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Will Appear
        
        let filteredArray = userInfo.filter() { $0.city == "New York" }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return userInfo.count
    }
    
    //Fill Cell
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Inside The Cell
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell")
        
        let label1 = cell?.viewWithTag(1) as! UILabel
        label1.text = userInfo[indexPath.row].firstName
        
        let label2 = cell?.viewWithTag(2) as! UILabel
        label2.text = userInfo[indexPath.row].city
        
        let label3 = cell?.viewWithTag(3) as! UILabel
        label3.text = userInfo[indexPath.row].limits
        
        cell?.imageView?.image = userInfo[indexPath.row].profilePhoto
        
        //Boder Cell Color
        
        cell?.layer.borderWidth = 4.0
        cell?.layer.borderColor = UIColor.flatGreen.cgColor
        
        //Circular Image View

        cell?.imageView?.layer.cornerRadius = (cell?.imageView?.frame.width)! / 2
        cell?.imageView?.clipsToBounds = true
        
        return cell!
    }
    
    func fetchUsersInfo() {
        
        refHandle = ref.child("User Posts").observe(.childAdded, with: { (snapshot) in
            
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

}
