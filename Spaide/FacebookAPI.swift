//
//  AudioAPI.swift
//  Spaide
//
//  Created by Deborah on 5/11/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FacebookCore
import FacebookLogin
import SVProgressHUD

class FacebookAPI {

    //Logout Function
    
    func logoutUser(controller: UIViewController) {
        
        try! Auth.auth().signOut()
        if let storyboard = controller.storyboard {
            let vc = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            controller.present(vc, animated: true, completion: nil)
        }
    }
    
    //Login Function
    
    func facebookLogin(controller: UIViewController) {
        
        let loginManager = LoginManager()
        loginManager.logIn([.publicProfile, .email], viewController: controller) { (loginResult) in
            
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
            
            SVProgressHUD.show(withStatus: "Logging In With Facebook...")
            
            Auth.auth().signIn(with: credential, completion: { (user, error) in
                
                if let error = error {
                    print(error.localizedDescription)
                    
                    let alertController = UIAlertController(title: "Login Error!", message: "Try Again!", preferredStyle: .alert)
                    let okayAction = UIAlertAction(title: "Try Again!", style: .cancel, handler: nil)
                    alertController.addAction(okayAction)
                    controller.present(alertController, animated: true, completion: nil)
                    
                } else {
                    
                    SVProgressHUD.dismiss()
                    
                    //Present Tab Bar Controller
                    
                    let newVC = controller.storyboard?.instantiateViewController(withIdentifier: "TableViewController")
                    controller.present(newVC!, animated: true, completion: nil)
                }
            })
            
        }
        
    }
    
    //Instance
    
    class func sharedInstance() -> FacebookAPI {
        struct Singleton {
            static var sharedInstance = FacebookAPI()
        }
        return Singleton.sharedInstance
    }

} //End Class
