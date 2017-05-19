//
//  AudioAPI.swift
//  Spaide
//
//  Created by Deborah on 5/11/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import UIKit
import Firebase
import FacebookCore
import FacebookLogin

class FacebookAPI: LoginViewController {

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
        loginManager.logIn([.publicProfile, .email], viewController: self) { (loginResult) in
            
            switch loginResult {
                
            case .failed(let error):
                print(error)
                
            case .cancelled:
                print("User Cancelled Login")
                
            case .success(grantedPermissions: _, declinedPermissions: _, token: _):
                
                print("Logged In!")
            }
            
            let credential = FacebookAuthProvider.credential(withAccessToken: (AccessToken.current?.authenticationToken)!)
            
            //Perform Login By Calling Firebase APIs
            
            Auth.auth().signIn(with: credential, completion: { (user, error) in
                
                if let error = error {
                    print(error.localizedDescription)
                    
                    let alertController = UIAlertController(title: "Login Error!", message: "Try Again!", preferredStyle: .alert)
                    let okayAction = UIAlertAction(title: "Try Again!", style: .cancel, handler: nil)
                    alertController.addAction(okayAction)
                    self.present(alertController, animated: true, completion: nil)
                    
                } else {
                    
                    //Present Tab Bar Controller
                    
                    let newVC = self.storyboard?.instantiateViewController(withIdentifier: "TabBarController")
                    self.present(newVC!, animated: true, completion: nil)
                }
            })
            
        }
        
    }

} //End Class
