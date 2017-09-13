//
//  Pin.swift
//  Spaide
//
//  Created by Deborah on 9/6/17.
//  Copyright © 2017 Deborah. All rights reserved.
//


import Foundation
import CoreData
import MapKit

//Pin Class

public class Pin: NSManagedObject {
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
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
