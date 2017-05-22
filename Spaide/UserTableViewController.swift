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
import FirebaseAuth
import FirebaseStorage
import FacebookCore
import FacebookLogin
import MessageUI

struct UserStruct {
    
    var firstName: String?
    var city: String?
    var limits: String?
}

class UserTableViewController: UITableViewController, UINavigationControllerDelegate, MFMailComposeViewControllerDelegate {

    //Variables
    
    var refHandle: UInt!
    var userPosts = [UserStruct]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let databaseReference = Database.database().reference()
        
        databaseReference.child("Profile").queryOrderedByKey().observe(.childAdded, with: { (snapshot) in
            
            var snapshotValue = snapshot.value as? NSDictionary
            
            let firstName = snapshotValue!["firstName"] as? String
            snapshotValue = snapshot.value as? NSDictionary
            
            let city = snapshotValue!["city"] as? String
            snapshotValue = snapshot.value as? NSDictionary
            
            let limits = snapshotValue!["limits"] as? String
            snapshotValue = snapshot.value as? NSDictionary
            
            self.userPosts.insert(UserStruct(firstName: firstName, city: city, limits: limits), at: self.userPosts.count)
            self.tableView.reloadData()
            
            
            
        })
        
        print(userPosts)
        
        
    }
    
    //Compose Email Message
    
    func configuredMailComposedViewController() -> MFMailComposeViewController {
        
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients([(Auth.auth().currentUser?.email)!])
        mailComposerVC.setSubject("Hey! I saw you on Spaide. Looking to connect.")
        mailComposerVC.setMessageBody("Hey there! I had a few questions and was hoping you could help.", isHTML: false)
        
        return mailComposerVC
    }
    
    //Email Alert
    
    func emailAlert() {
        
        let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Something Went Wrong. Try Again!", delegate: self, cancelButtonTitle: "OK")
        
        sendMailErrorAlert.show()
    }
    
    //Mail Interface Functions
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        switch result {
            
        case .cancelled:
            print("Mail Cancelled")
            
        case .saved:
            print("Mail Saved")
            
        case .sent:
            print("Mail Sent")
            
        default:
            break
        }
        
        //Close Mail Interface
        
        self.dismiss(animated: true, completion: nil)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return userPosts.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let mailComposeViewController = configuredMailComposedViewController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            
            self.emailAlert()
        }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Set Cell Contents
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell") as! CustomTableViewCell
        
        cell.firstNameLabel.text = userPosts[indexPath.row].firstName
        cell.locationLabel.text = userPosts[indexPath.row].city
        cell.limitationsLabel.text = userPosts[indexPath.row].limits
        
        if let user = Auth.auth().currentUser {
            
            //Get Facebook Profile Photo
            
            let photoURL = user.photoURL
            
            let storage = Storage.storage()
            
            let storageRef = storage.reference(forURL: "gs://spaide-2cc40.appspot.com")
            
            // Create a reference to the file you want to download
            let profilePicRef = storageRef.child("images/island.jpg")
            
            // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
            profilePicRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
                if (error != nil) {
                    
                    print("Unable To Get Image!")
                    
                } else {
                    
                    if (data != nil) {
                        
                        cell.profileView.image = UIImage(data: data!)
                    }
                }
            }
            
            if (cell.profileView.image == nil) {
            
            var profilePic = GraphRequest(graphPath: "me/picture", parameters: ["height": 300, "width": "300", "redirect": false], httpMethod: GraphRequestHTTPMethod(rawValue: "GET")!)
            profilePic.start({ (connection, result, erorr) in
                
                if (error == nil) {
                    
                    //Save Photo To Firebase
                    
                    let dictionary = result as? NSDictionary
                    let data = dictionary?.object(forKey: "data")
                    
                    let urlPic = (data.object(forKey: "url")) as! String
                    
                    if let imageData = try! Data(contentsOf: URL(string:urlPic)!) {
                        let profilePicRef = storageRef.child(user.uid+"/profile_pic.jpg")
                        
                        //Upload Picture
                        
                        let uploadTask = profilePicRef.putData(imageData, metadata: nil) {
                            metadata, error in
                            
                            if (error == nil) {
                                
                                let downloadURL = metadata!.downloadURL
                            } else {
                                
                                print("Error Downloading Image!")
                            }
                        }
                        
                        cell.profileView.image = UIImage(data: imageData)
                    }
                    
                }
            })
                
        }
            
            
        } else {
            
            //No User Is Signed In, Upload Default Picture
            
            cell.profileView.image = UIImage(named: "")
        }
        
        return cell
    
    }


} //End Of Class
