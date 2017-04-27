//
//  User.swift
//  Spaide
//
//  Created by Deborah on 4/27/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import UIKit

struct User {
    
    var firstName = String()
    var limitations = String()
    var city = String()
    
    init(firstName: String, limitations: String, city: String) {
        
        self.firstName = firstName
        self.limitations = limitations
        self.city = city
    }
    
}
