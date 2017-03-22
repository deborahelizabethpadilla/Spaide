//
//  InputController.swift
//  Spaide
//
//  Created by Deborah on 3/22/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import UIKit
import ChameleonFramework

class InputController: UIViewController {
    
    //Outlets
    
    @IBOutlet var postLabel: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set Background
        
        view.backgroundColor = FlatGreenDark()
        
        //Button Colors & Size
        
        postLabel.backgroundColor = .flatWatermelonDark
        postLabel.layer.cornerRadius = 5
        postLabel.layer.borderWidth = 1
        postLabel.layer.borderColor = UIColor.flatWatermelonDark.cgColor
        
        
    }
}
