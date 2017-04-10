//
//  FacebookProfile.swift
//  Spaide
//
//  Created by Deborah on 4/10/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import Foundation
import Firebase

//Facebook Photo Class

public class FacebookPhoto: NSManagedObject {
    
    //Firebase Storage Reference
    
    let storageRef = FIRStorage.storage().reference()
    
    //Firebase Database Reference
    
    let databaseRef = FIRDatabase.database().reference()
    
    convenience init(index:Int, imageURL: String, imageData: NSData?, context: NSManagedObjectContext) {
        
        let pictureRequest = FBSDKGraphRequest(graphPath: "me/picture?type=large&redirect=false", parameters: nil)
        pictureRequest.startWithCompletionHandler({
            (connection, result, error: NSError!) -> Void in
            
            if error == nil {
                
                println("\(result)")
                
                
                
            } else {
                
                println("\(error)")
            }
        })
    
    }

}
