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
        //Tab Bar Design
        let topBorder = CALayer()
        topBorder.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 0.5)
        topBorder.backgroundColor = UIColor.black as! CGColor
        tabBar.layer.addSublayer(topBorder)
    }

} //End Class
