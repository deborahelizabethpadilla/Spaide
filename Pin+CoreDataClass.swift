//
//  Pin+CoreDataClass.swift
//  Spaide
//
//  Created by Deborah on 9/18/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import Foundation
import CoreData


public class Pin: NSManagedObject {
    
    convenience init(latitude: Double, longitude: Double, context: NSManagedObjectContext) {
        if let ent = NSEntityDescription.entity(forEntityName: "Pin", in: context) {
            
            self.init(entity: ent, insertInto: context)
            self.latitude = latitude
            self.longitude = longitude
        } else {
            fatalError("Unable To Find Entity Name!")
        }
    }
}
