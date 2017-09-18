//
//  Pin+CoreDataProperties.swift
//  Spaide
//
//  Created by Deborah on 9/18/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import Foundation
import CoreData


extension Pin {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Pin> {
        return NSFetchRequest<Pin>(entityName: "Pin")
    }

    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double

}
