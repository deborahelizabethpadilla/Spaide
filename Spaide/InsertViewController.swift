//
//  InsertViewController.swift
//  Spaide
//
//  Created by Deborah on 9/12/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import UIKit

class InsertViewController: UIViewController {

    @IBOutlet weak var addressText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Text Field Design
        
        let myColor = UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 1.0)
        
        addressText.layer.cornerRadius = 15.0
        addressText.layer.borderWidth = 4.0
        addressText.layer.borderColor = myColor.cgColor
    }

} // End Class
