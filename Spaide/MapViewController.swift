//
//  MapViewController.swift
//  Spaide
//
//  Created by Deborah on 9/5/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import UIKit
import MapKit
import CoreData
import Firebase
import FirebaseDatabase

class MapViewController: UIViewController, MKMapViewDelegate, UIGestureRecognizerDelegate {
    
    //Variables
    var gestureBegin: Bool = false
    var currentPins:[Pin] = []
    
    //Outlets
    
    @IBOutlet weak var mapView: MKMapView!
    
    //Action
    
    @IBAction func responseLongTap(_ sender: UILongPressGestureRecognizer) {
        
        if gestureBegin {
            let gestureRecognizer = sender 
            let gestureTouchLocation = gestureRecognizer.location(in: mapView)
            addAnnotationToMap(fromPoint: gestureTouchLocation)
            gestureBegin = false
        }
    }
    
    //Gesture Recognizer
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        gestureBegin = true
        return true
    }
    
    //Add Pin
    
    func addAnnotationToMap(fromPoint: CGPoint) {
        
        let coordToAdd = mapView.convert(fromPoint, toCoordinateFrom: mapView)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordToAdd
        addCoreData(of: annotation)
        mapView.addAnnotation(annotation)
        
    }
    
    func addAnnotationToMap(fromCoord: CLLocationCoordinate2D) {
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = fromCoord
        mapView.addAnnotation(annotation)
    }
    
    //Add Core Data
    
    func addCoreData(of: MKAnnotation) {
        
        do {
            
            let coord = of.coordinate
            let pin = Pin(latitude: coord.latitude, longitude: coord.longitude, context: getCoreDataStack().context)
            try getCoreDataStack().saveContext()
            currentPins.append(pin)
            
        } catch {
            
            print("Add Core Data Failed")
        }
    }
    
    //Core Data
    
    func getCoreDataStack() -> CoreDataStack {
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        return delegate.stack
    }
    
    //Fetch Results
    
    func getFetchedResultsController() -> NSFetchedResultsController<NSFetchRequestResult> {
        
        let stack = getCoreDataStack()
        
        let fr = NSFetchRequest<NSFetchRequestResult>(entityName: "Pin")
        fr.sortDescriptors = []
        
        return NSFetchedResultsController(fetchRequest: fr, managedObjectContext: stack.context, sectionNameKeyPath: nil, cacheName: nil)
    }
    
    //Load Saved Pin
    
    func preloadSavedPin() -> [Pin]? {
        
        do {
            
            var pinArray:[Pin] = []
            let fetchedResultsController = getFetchedResultsController()
            try fetchedResultsController.performFetch()
            let pinCount = try fetchedResultsController.managedObjectContext.count(for: fetchedResultsController.fetchRequest)
            for index in 0..<pinCount {
                
                pinArray.append(fetchedResultsController.object(at: IndexPath(row: index, section: 0)) as! Pin)
            }
            
            return pinArray
            
        } catch {
            
            return nil
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Add Annotation
        
        let savedPins = preloadSavedPin()
        if savedPins != nil {
            currentPins = savedPins!
            
            for pin in currentPins {
                let coord = CLLocationCoordinate2D(latitude: pin.latitude, longitude: pin.longitude)
                addAnnotationToMap(fromCoord: coord)
            }
        }
        
    }
    
} // End Class
