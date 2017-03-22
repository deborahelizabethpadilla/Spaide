//
//  PostController.swift
//  Spaide
//
//  Created by Deborah on 3/22/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import UIKit
import ChameleonFramework
import Firebase
import FirebaseDatabase

//Exactly What Post Will Read

struct postStruct {
    
    let title: String!
    let message: String!
}

class PostController: UITableViewController {
    
    //Let Posts Be In Array
    
    let posts = [postStruct]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Grab From Database
        
        let databaseRef = FIRDatabase.database().reference()
        
        databaseRef.child("Posts").queryOrderedByKey().observe(.childAdded, with:  {
            snapshot in
            
            let title = snapshot.value!["title"] as! String
            let message = snapshot.value!["message"] as! String
            
            posts.insert(postStruct(title: title, message: message) ,at: 0)
            self.tableView.reloadData()
            
    })
        
        //Post
        
        post()
        
        //Set Background Color
        
        view.backgroundColor = FlatGreenDark()
        
    }
    
    func post() {
        
        //Store In Database
        
        let title = "Title"
        let message = "Message"
        
        //Key For What Were Uploading
        
        let post : [String : AnyObject] = ["title" : title, "message" : message]
        
        //Store In Database
        
        let databaseRef = FIRDatabase.database().reference()
        
        //Reference Part Of Database
        
        databaseRef.child("Posts").childByAutoId().setValue(post)
    
    }
    
    //Table View Functions
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //Count How Many Things Inside Array
        
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Post In Cell
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        let label1 = cell?.viewWithTag(1) as! UILabel
        label1.text = posts[indexPath.row].title
        
        
        let label2 = cell?.viewWithTag(2) as! UILabel
        label2.text = posts[indexPath.row].message
        
        
        return cell!
    }

}
