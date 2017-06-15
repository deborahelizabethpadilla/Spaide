//
//  TabBarController.swift
//  Spaide
//
//  Created by Deborah on 5/19/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //Make Unselected Icons A Different Color
        
        self.tabBar.unselectedItemTintColor = UIColor.yellow
    }

}
