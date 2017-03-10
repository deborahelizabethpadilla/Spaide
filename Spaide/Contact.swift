//
//  Contacts.swift
//  Spaide
//
//  Created by Deborah on 3/10/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import Foundation

class Contact {
    
    //Contact Variables
    
    private var _name = ""
    private var _ID = ""
    
    //Set Initalizer To Set Things Up When Fetching Data
    
    init(id: String, name: String) {
        
        _ID = id
        _name = name
    }
    
    var name: String {
       
        get {
            
            return _name
            
        }
    }
    
    var id:String {
        
        return _ID
    }
    
}
