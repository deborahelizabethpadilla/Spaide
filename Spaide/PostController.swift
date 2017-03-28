//
//  PostController.swift
//  Spaide
//
//  Created by Deborah on 3/22/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import UIKit
import ChameleonFramework
import CoreData

class PostController: UITableViewController {
    
    
    //Variables
    
    var coordinateSelected:CLLocationCoordinate2D!
    let spacingBetweenItems:CGFloat = 5
    let totalCellCount:Int = 25
    
    var stack:CoreDataStack!
    var coreDataCell:Cell!
    var savedImages:[Photo] = []
    var selectedToDelete:[Int] = [] {
        
        didSet {
            
            if selectedToDelete.count > 0 {
                
                newCollectionButton.setTitle("Remove Selected Pictures", for: .normal)
                
            } else {
                
                newCollectionButton.setTitle("New Collection", for: .normal)
            }
        }
    }
    
    //Core Data Stack
    
    func getCoreDataStack() -> CoreDataStack {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        return delegate.stack
    }
    
    //Fetch Results
    
    func getFetchedResultsController() -> NSFetchedResultsController<NSFetchRequestResult> {
        
        let stack = getCoreDataStack()
        
        let fr = NSFetchRequest<NSFetchRequestResult>(entityName: "Photo")
        fr.sortDescriptors = []
        fr.predicate = NSPredicate(format: "cell = %@", argumentArray: [coreDataCell!])
        
        return NSFetchedResultsController(fetchRequest: fr, managedObjectContext: stack.context, sectionNameKeyPath: nil, cacheName: nil)
        
        
    }
    
    //Saved Photo
    
    func preloadSavedPhoto() -> [Photo]? {
        
        do {
            
            var photoArray:[Photo] = []
            let fetchedResultsController = getFetchedResultsController()
            try fetchedResultsController.performFetch()
            let photoCount = try fetchedResultsController.managedObjectContext.count(for: fetchedResultsController.fetchRequest)
            
            for index in 0..<photoCount {
                
                photoArray.append(fetchedResultsController.object(at: IndexPath(row: index, section: 0)) as! Photo)
            }
            
            return photoArray.sorted(by: {$0.index < $1.index})
            
        } catch {
            
            return nil
        }
    }
    
    //View Did Load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Background
        
        view.backgroundColor = FlatGreenDark()
        
        //Flow Layout
        
        let space: CGFloat = 3.0
        let dimension = (self.view.frame.size.width - (2 * space)) / 3.0
        
        flowLayout.minimumInteritemSpacing = spacingBetweenItems
        flowLayout.minimumLineSpacing = spacingBetweenItems
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
        
        //Collection View
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        //Button & Label
        
        newCollectionButton.isHidden = false
        noPhotos.isHidden = true
        
        //Add To Map
        
        collectionView.allowsMultipleSelection = true
        addAnnotationToMap()
        
        //Fetch Photos
        
        let savedPhoto = preloadSavedPhoto()
        if savedPhoto != nil && savedPhoto?.count != 0 {
            savedImages = savedPhoto!
            showSavedResult()
            
        } else {
            
            showNewResult()
        }
    }

}
