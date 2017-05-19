//
//  FacebookPhotoAPI.swift
//  Spaide
//
//  Created by Deborah on 5/18/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import UIKit
import Foundation
import FacebookCore
import FacebookLogin
import Firebase

class FacebookPhotoAPI {
    
    //Get FB Profile Picutre
    
    func getProfPic(user: String) -> UIImage? {
        
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
