//
//  FacebookAPIAssist.swift
//  Spaide
//
//  Created by Deborah on 5/12/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

extension FacebookAPI {
    
    func getProfPic(fid: String) -> UIImage? {
        if (fid != "") {
            var imgURLString = "http://graph.facebook.com/" + fid! + "/picture?type=large" //type=normal
            var imgURL = NSURL(string: imgURLString)
            var imageData = NSData(contentsOfURL: imgURL!)
            var image = UIImage(data: imageData!)
            return image
        }
        return nil
    }
}
