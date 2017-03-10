//
//  Authorization.swift
//  Spaide
//
//  Created by Deborah on 3/10/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import Foundation
import FirebaseAuth

class Authorization {
    
    //Login User
    
    func isLoggedIn() -> Bool {
        
        if FIRAuth.auth()?.currentUser != nil {
            
            return true
        }
        
        return false
    }

    //Logout User
    
    func logOut() -> Bool {
        
        if FIRAuth.auth()?.currentUser != nil {
            do {
                
                try FIRAuth.auth()?.signOut()
                
                return true
            } catch {
                
                return false
            }
        }
        
        return true
    }
    
    //User ID
    
    func userID() -> String {
        
        return FIRAuth.auth()!.currentUser!.uid
         
    }
}


