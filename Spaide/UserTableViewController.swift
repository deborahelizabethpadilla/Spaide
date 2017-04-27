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
    
    let firstName : String!
    let limitations : String!
    let pickerView = String!
    
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
            
            let firstName = snapshot.value![""] as! String
            let limitations = snapshot.value![""] as! String
            let pickerChoice = snapshot.value![] as! String
            let profilePic = snapshot.value![] as! UIImage
            
            self.posts.insert(postStruct(firstName: , limitations: , pickerChoice: , profilePic: ), at: 0)
            self.tableView.reloadData()
            
        })

       post()
    }
    
    //Posts
    
    func post() -> {
        
        let firstName =
        let limitations =
        
        let post : [String : AnyObject] = []
        
        let databaseRef = FIRDatabase.database().reference()
        
        databaseRef.child("Profile Posts").childByAutoId().setValue(post)
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return
    }
    
    //Fill Cell
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "userCell")
        
        let firstNameLabel = cell?.viewWithTag(1) as! UILabel
        firstNameLabel.text = posts[indexPath.row].firstName
        
        let limitationsLabel = cell?.viewWithTag(2) as! UILabel
        limitationsLabel.text = posts[indexPath.row].limitations
        
        
        return cell!
    }

}
