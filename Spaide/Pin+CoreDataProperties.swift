//
//  Pin+CoreDataProperties.swift
//  
//
//  Created by Deborah on 9/13/17.
//
//

import Foundation
import CoreData


extension Pin {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Pin> {
        return NSFetchRequest<Pin>(entityName: "Pin")
    }

    @NSManaged public var latitude: Double
    @NSManaged public var longitutde: Double

}
