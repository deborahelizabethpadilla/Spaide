//
//  PinProperties.swift
//  Spaide
//
//  Created by Deborah on 9/6/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import Foundation
import CoreData

//Pin Class

extension Pin {
    
    //Fetch Pin
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Pin> {
        return NSFetchRequest<Pin>(entityName: "Pin");
    }
    
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var photo: NSSet?
    
}
