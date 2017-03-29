//
//  FormController.swift
//  Spaide
//
//  Created by Deborah on 3/28/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import UIKit
import ChameleonFramework

class FormController: UIViewController {
    
    @IBOutlet var profilebackgroundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set Background To View Near Profile Pic
        
        profilebackgroundView.backgroundColor = FlatWatermelonDark()
    }
}
