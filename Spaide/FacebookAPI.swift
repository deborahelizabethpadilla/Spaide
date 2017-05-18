//
//  AudioAPI.swift
//  Spaide
//
//  Created by Deborah on 5/11/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import UIKit
import Firebase

class FacebookAPI: LoginViewController {
    
    //Shared Instance
    
    class func sharedInstance() -> FacebookAPI {
        struct Singleton {
            static var sharedInstance = FacebookAPI()
        }
        return Singleton.sharedInstance
    }

    //Logout Function
    
    func logoutUser(controller: UIViewController) {
        
        try! Auth.auth().signOut()
        if let storyboard = self.storyboard {
            let vc = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    //Login Function
    
    func facebookLogin() {
        
        let loginManager = LoginManager()
        loginManager.logIn([ .PublicProfile ], viewController: self) { loginResult in
            switch loginResult {
            case .Failed(let error):
                print(error)
            case .Cancelled:
                print("User Cancelled Login.")
            case .Success(let grantedPermissions, let declinedPermissions, let accessToken):
                print("Logged in!")
            }
            
            let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
            
            // Perform Login By Calling Firebase APIs
            
            Auth.auth().signIn(with: credential, completion: { (user, error) in
                if let error = error {
                    print("Login error: \(error.localizedDescription)")
                    let alertController = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle: .alert)
                    let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(okayAction)
                    self.present(alertController, animated: true, completion: nil)
                    
                    return
                }
                
                // Present Tab Bar Controller
                
                if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "TabBarController") {
                    UIApplication.shared.keyWindow?.rootViewController = viewController
                    self.dismiss(animated: true, completion: nil)
                }
                
            })
            
        }
    }
    
} //End Class
