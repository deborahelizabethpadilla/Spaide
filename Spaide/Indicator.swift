//
//  Indicator.swift
//  Spaide
//
//  Created by Deborah on 4/27/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import UIKit

//Activity Indicator 

class Indicator: UIActivityIndicatorView {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    required init(coder aDecoder: NSCoder){
        fatalError("use init(")
    }
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        self.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
    }
    
    func loadingView(_ isloading: Bool) {
        if isloading {
            self.startAnimating()
        } else {
            self.stopAnimating()
            self.hidesWhenStopped = true
            
        }
    }
    
}
