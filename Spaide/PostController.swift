//
//  PostController.swift
//  Spaide
//
//  Created by Deborah on 3/22/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import UIKit
import Eureka

class PostController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addLoginForm(toForm: form)
    }
    
    let section = Section("Login Form")
    
    section.append(TextRow() { $0.placeholder = "Username" })
    section.append(PasswordRow() { $0.placeholder = "Password" })
    section.append(
    ButtonRow() {
    $0.title = "Login"
    $0.onCellSelection { cell, row in
    self.presentAlert(message: "Will login")
    }
    }
    )
    
    form.append(section)
}
