//
//  Messages.swift
//  Spaide
//
//  Created by Deborah on 3/13/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage

 //Protocol For Message Received

protocol MessageReceivedDelegate: class {
    
    func messageReceived(senderID: String, senderName: String, text: String)
    
    func mediaReceived(senderID: String, senderName: String, url: String)
}

class MessagesHandler {
    
    //Variables
    
    private static let _instance = MessagesHandler()
    private init() {}
    
    weak var delegate: MessageReceivedDelegate?
    
    static var Instance: MessagesHandler {
        
        return _instance
    }
    
    //Send Message
    
    func sendMessage(senderID: String, senderName: String, text: String) {
        
        let data: Dictionary<String, Any> = [Constants.SENDER_ID: senderID, Constants.SENDER_NAME: senderName, Constants.TEXT: text]
        
        DataBase.Instance.messagesRef.childByAutoId().setValue(data)
        
    }
    
    //Send Media Message
    
    func sendMediaMessage(senderID: String, senderName: String, url: String) {
        
        let data: Dictionary<String, Any> = [Constants.SENDER_ID: senderID, Constants.SENDER_NAME: senderName, Constants.URL: url]
        
        DataBase.Instance.mediaMessagesRef.childByAutoId().setValue(data)
    }
    
    //Send Media
    
    func sendMedia(image: Data?, video: URL?, senderID: String, senderName: String) {
        
        if image != nil {
            
            DataBase.Instance.imageStorageRef.child(senderID + "\(NSUUID().uuidString).jpg").put(image!, metadata: nil) { (metadata: FIRStorageMetadata?, err: Error?) in
                
                if err != nil {
                    
                    //Let User Know Uploading Image Has Failed
                    
                    self.displayAlert(title: "Oh No!", message: "Upload Of Image Failed!")
                    
                } else {
                    
                    self.sendMediaMessage(senderID: senderID, senderName: senderName, url: String(describing: metadata!.downloadURL()!));
                }
                
            }
            
        } else {
            
            DataBase.Instance.videoStorageRef.child(senderID + "\(NSUUID().uuidString)").putFile(video!, metadata: nil) { (metadata: FIRStorageMetadata?, err: Error?) in
                
                if err != nil {
                    
                    //Let User Know Uploading Video Has Failed
                    
                    self.displayAlert(title: "Oh No!", message: "Upload Of Video Failed!")
                    
                } else {
                    
                    self.sendMediaMessage(senderID: senderID, senderName: senderName, url: String(describing: metadata!.downloadURL()!))
                }
                
            }
        }
        
    }
    
    //Observe Messages
    
    func observeMessages() {
        
        DataBase.Instance.messagesRef.observe(FIRDataEventType.childAdded) { (snapshot: FIRDataSnapshot) in
            
            if let data = snapshot.value as? NSDictionary {
                
                if let senderID = data[Constants.SENDER_ID] as? String {
                    
                    if let senderName = data[Constants.SENDER_NAME] as? String {
                        
                        if let text = data[Constants.TEXT] as? String {
                            
                            self.delegate?.messageReceived(senderID: senderID, senderName: senderName, text: text)
                        }
                    }
                }
            }
            
        }
    }
    
    //Observe Media Messages
    
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
}
