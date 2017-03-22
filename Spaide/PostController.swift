//
//  PostController.swift
//  Spaide
//
//  Created by Deborah on 3/22/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import UIKit
import Eureka

class PostController: FormViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addLoginForm(toForm: form)
    }
    
    private func addLoginForm(toForm form: Form) {
        form +++ Section("Login Form")
            <<< TextRow() { $0.placeholder = "Username" }
            <<< PasswordRow() { $0.placeholder = "Password" }
            <<< ButtonRow() {
                $0.title = "Login"
                $0.onCellSelection { cell, row in
                    self.presentAlert(message: "Will login")
                }
        }
    }
}
