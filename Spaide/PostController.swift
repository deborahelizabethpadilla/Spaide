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
            let uLocation = snapshot.value!["uLocation"] as! String
            let needs = snapshot.value!["needs"] as! String
            let uImage = snapshot.value!["uImage"] as! UIImage
            
            posts.insert(postStruct(title: title, message: message, uLocation: uLocation, needs: needs, uImage: uImage) ,at: 0)
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
        let uLocation = "Location"
        let needs = "Needs"
        let uImage = UIImage
        
        //Key For What Were Uploading
        
        let post : [String : AnyObject] = ["title" : title, "message" : message, "uLocation" : uLocation, "needs" : needs, "uImage" :uImage]
        
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
        
        let label3 = cell?.viewWithTag(2) as! UILabel
        label3.text = posts[indexPath.row].uLocation
        
        let label4 = cell?.viewWithTag(2) as! UILabel
        label4.text = posts[indexPath.row].needs
        
        let UIImage = cell?.viewWithTag(2) as! UIImage
        UIImage = posts[indexPath.row].uImage
        
        
        return cell!
    }

}
