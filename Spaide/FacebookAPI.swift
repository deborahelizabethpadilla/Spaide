//
//  AudioAPI.swift
//  Spaide
//
//  Created by Deborah on 5/11/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit


class FacebookAPI: LoginViewController {
    
    //Functions
    
    func logoutUser(controller: UIViewController) {
        
        let firebaseAuth = FIRAuth.auth()
        do {
            try firebaseAuth?.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    //Login Function
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        
        if (error != nil) {
            
            print(error.localizedDescription)
            
        }
        
        if let userToken = result.token {
            
            let token:FBSDKAccessToken = result.token
            
            print("Token = \(FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString))")
            print("User ID = \(FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().userID))")
            
            self.storyboard?.instantiateViewController(withIdentifier: "TabBarController")
            
        }
        
    }
    
    //Shared Instance
    
    class func sharedInstance() -> FacebookAPI {
        struct Singleton {
            static var sharedInstance = FacebookAPI()
        }
        return Singleton.sharedInstance
    }
    
} //End Class
