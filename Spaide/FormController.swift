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
    
    //Outlets
    
    @IBOutlet var profilebackgroundView: UIView!
    @IBOutlet var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set Background To View Near Profile Pic
        
        profilebackgroundView.backgroundColor = FlatWatermelonDark()
        
        //Set Save Button 
        
        saveButton.backgroundColor = FlatWatermelonDark()
    }
    
    //Actions
    
    @IBAction func saveButtonAction(_ sender: Any) {
        
        
    }
    
}
