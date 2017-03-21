//
//  TermsOfServiceController.swift
//  Spaide
//
//  Created by Deborah on 3/21/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import UIKit
import ChameleonFramework

class TermsOfServiceController: UIViewController {
    
    //Outlets
    
    @IBOutlet var navigationBar: UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Navigation Bar
        
        navigationBar.backgroundColor = FlatGreenDark()
    }
}
