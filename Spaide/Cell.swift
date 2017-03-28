//
//  Cell.swift
//  Spaide
//
//  Created by Deborah on 3/27/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import Foundation
import CoreData

//Cell Class

public class Cell: NSManagedObject {
    
    //Cell Setup
    
    convenience init(latitude: Double, longitude: Double, context: NSManagedObjectContext) {
        
        if let ent = NSEntityDescription.entity(forEntityName: "Cell", in: context) {
            
            self.init(entity: ent, insertInto: context)
            self.latitude   = latitude
            self.longitude  = longitude
            
        } else {
            
            fatalError("Unable To Find Entity Name!")
        }
    }
    
}
