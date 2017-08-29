//
//  TabBarViewController.swift
//  Spaide
//
//  Created by Deborah on 8/29/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Change Border Color
        tabBar.layer.borderWidth = 0.3
        tabBar.layer.borderColor = UIColor.black as? CGColor
        tabBar.clipsToBounds = true
        //Tab Bar Color
        self.tabBarController?.tabBar.tintColor = UIColor.black
    }

} //End Class
