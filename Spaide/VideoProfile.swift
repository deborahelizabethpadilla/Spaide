//
//  VideoProfile.swift
//  Spaide
//
//  Created by Deborah on 3/14/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage

 //Protocol For Video Received For Profile

protocol ProfileReceivedDelegate: class {
    
    func profileReceived(senderID: String, senderName: String, text: String)
    
    func profileReceived(senderID: String, senderName: String, url: String)
}

class ProfileHandler {
    
    //Variables
    
    private static let _instance = ProfileHandler()
    private init() {}
    
    weak var delegate: ProfileReceivedDelegate?
    
    static var Instance: ProfileHandler {
        
        return _instance
    }
    
    //Send Media Message
    
    func sendMediaMessage(senderID: String, senderName: String, url: String) {
        
        let data: Dictionary<String, Any> = [Constants.SENDER_ID: senderID, Constants.SENDER_NAME: senderName, Constants.URL: url]
        
        DataBase.Instance.mediaMessagesRef.childByAutoId().setValue(data)
    }
    
    //Send Video
    
    func sendMedia(image: Data?, video: URL?, senderID: String, senderName: String) {
            
            DataBase.Instance.videoStorageRef.child(senderID + "\(NSUUID().uuidString)").putFile(video!, metadata: nil) { (metadata: FIRStorageMetadata?, err: Error?) in
                
                if err != nil {
                    
                    //Let User Know Uploading Video Has Failed
                    
                    displayAlert(title: "Oh No!", message: "Upload Of Video Failed!")
                    
                } else {
                    
                    self.sendMediaMessage(senderID: senderID, senderName: senderName, url: String(describing: metadata!.downloadURL()!))
                }
                
            }
        }
        
    }
    
    //Observe Video Messages
    
    func observeMediaMessages() {
        
        DataBase.Instance.mediaMessagesRef.observe(FIRDataEventType.childAdded) { (snapshot: FIRDataSnapshot) in
            
            if let data = snapshot.value as? NSDictionary {
                
                if let id = data[Constants.SENDER_ID] as? String {
                    
                    if let name = data[Constants.SENDER_NAME] as? String {
                        
                        if let fileURL = data[Constants.URL] as? String {
                            
                            self.delegate?.mediaReceived(senderID: id, senderName: name, url: fileURL)
                        }
                    }
                }
            }
            
        }
    }
    
    //Display Alert
    
    func displayAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            
            self.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }

