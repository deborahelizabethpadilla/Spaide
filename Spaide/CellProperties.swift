//
//  CellProperties.swift
//  Spaide
//
//  Created by Deborah on 3/28/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import Foundation
import CoreData

//Cell Class

extension Cell {
    
    //Fetch Cell
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Pin> {
        return NSFetchRequest<Cell>(entityName: "Cell");
    }
    
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var photo: NSSet?
    
}

//Access Photo

extension Cell {
    
    @objc(addPhotoObject:)
    @NSManaged public func addToPhoto(_ value: Photo)
    
    @objc(removePhotoObject:)
    @NSManaged public func removeFromPhoto(_ value: Photo)
    
    @objc(addPhoto:)
    @NSManaged public func addToPhoto(_ values: NSSet)
    
    @objc(removePhoto:)
    @NSManaged public func removeFromPhoto(_ values: NSSet)
    
}
