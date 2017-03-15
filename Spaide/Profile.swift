//
//  Profile.swift
//  Spaide
//
//  Created by Deborah on 3/13/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import UIKit
import AVKit

class Profile: UIViewController {
    
    @IBOutlet var profileView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Make Profile View A Circle
        
        profileView.layer.cornerRadius = profileView.frame.size.width / 2
        profileView.clipsToBounds = true
    }
}

