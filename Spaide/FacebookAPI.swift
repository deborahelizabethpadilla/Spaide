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
    
    func facebookLogin() {
        
        //Facebook API
        
        let fbLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["public_profile", "email"], from: self) { (result, error) in
            if let error = error {
                print("Failed to login: \(error.localizedDescription)")
                return
            }
            
            guard let accessToken = FBSDKAccessToken.current() else {
                print("Failed to get access token")
                return
            }
            
            let credential = FIRFacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
            
            // Perform Login By Calling Firebase APIs
            
            FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
                if let error = error {
                    print("Login error: \(error.localizedDescription)")
                    let alertController = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle: .alert)
                    let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(okayAction)
                    self.present(alertController, animated: true, completion: nil)
                    
                    return
                }
                
                // Present Tab Controller
                
                if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "TabBarController") {
                    UIApplication.shared.keyWindow?.rootViewController = viewController
                    self.dismiss(animated: true, completion: nil)
                }
                
            })
            
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
