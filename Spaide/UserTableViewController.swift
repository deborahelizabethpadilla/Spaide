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
import FirebaseAuth
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
    
    var refUsers: DatabaseReference!
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
        mailComposerVC.setToRecipients([])
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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
        
        //Get FB Profile Picutre
        
        func getProfPic(fid: String) -> UIImage? {
            if (fid != "") {
                let imgURLString = "http://graph.facebook.com/" + fid + "/picture?type=large" //type=normal
                let imgURL = NSURL(string: imgURLString)
                let imageData = NSData(contentsOf: imgURL! as URL)
                let image = UIImage(data: imageData! as Data)
                var imageView = UIImageView()
                imageView = cell.viewWithTag(1) as! UIImageView
                imageView.image = image
                
                return image
            }
            return nil
        }
        
        
        return cell
    
    }
    
    func getFirebaseEmail() {
        
        let user = Auth.auth().currentUser
        if let user = user {
            
            let uid = user.uid
            let email = user.email
            
            return true
            
        } else {
            
            
        }
    }

} //End Of Class
