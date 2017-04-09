//
//  TabBarController.swift
//  Spaide
//
//  Created by Deborah on 3/23/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import UIKit
import ChameleonFramework

class TabBarController: UITabBarController {
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Tab Bar Background Color
        
        self.tabBar.barTintColor = FlatGreenDark()
        
    }
    
}
