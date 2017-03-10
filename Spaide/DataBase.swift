//
//  DataBase.swift
//  Spaide
//
//  Created by Deborah on 3/9/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage

class DataBase {
    
    //Data Base References
    
    private static let _instance = DataBase()
    
    private init() {}
    
    static var Instance: DataBase {
        
        return _instance
    }
    
    var dataRef: FIRDatabaseReference {
        
        return FIRDatabase.database().reference()
    }
    
    var contactsRef: FIRDatabaseReference {
        
        return dataRef.child(Constants.CONTACTS)
        
    }
    
    var messagesRef: FIRDatabaseReference {
        
        return dataRef.child(Constants.MESSAGES)
    }
    
    var mediaRef: FIRDatabaseReference {
        
        return dataRef.child(Constants.MEDIA_MESSAGES)
        
    }
    
    var storageRef: FIRStorageReference {
        
        return FIRStorage.storage().reference(forURL: "gs://spaide-2cc40.appspot.com")
    }
    
    var imageStorageRef: FIRStorageReference {
        
        return storageRef.child(Constants.IMAGE_STORAGE)
    }
    
    var videoStorageRef: FIRStorageReference {
        
        return storageRef.child(Constants.VIDEO_STORAGE)
    }
    
    func saveUser(withID: String, email: String, password: String) {
        
        let data: Dictionary<String, Any> = [Constants.EMAIL: email, Constants.PASSWORD: password]
        
        contactsRef.child(withID).setValue(data)
    }
    
}
