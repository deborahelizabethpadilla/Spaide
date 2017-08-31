//
//  RegisterTableViewController.swift
//  Spaide
//
//  Created by Deborah on 8/30/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import UIKit
import SVProgressHUD
import Firebase
import FirebaseAuth
import FirebaseDatabase

class RegisterTableViewController: UITableViewController {
    //Outlets
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    //Actions
    @IBAction func registerAction(_ sender: Any) {
        register()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //Button Designs
        registerButton.layer.cornerRadius = 15.0
        backButton.layer.cornerRadius = 15.0
        tableView.allowsSelection = false
    }
    
    func register() {
        Auth.auth().createUser(withEmail: emailField.text!, password: passwordField.text!) { (user, error) in
                if let user = Auth.auth().currentUser {
                    if !user.isEmailVerified {
                    //Failed
                    SVProgressHUD.show(withStatus: "That Email Is Taken!")
                } else {
                    //Go To Controller
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeView")
                    self.present(vc!, animated: true, completion: nil)
                        
                    }
            }
        }
    }

} //End Class
