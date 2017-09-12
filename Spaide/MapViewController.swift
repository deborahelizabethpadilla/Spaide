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
        
        
    }
    
    //Gesture Recognizer
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        gestureBegin = true
        return true
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
    
    //Add Core Data
    
    func addCoreData(of: MKAnnotation) {
        
        do {
            let coord = of.coordinate
            let pin = Pin(latitude: coord.latitude, longitude: coord.longitude, context: getCoreDataStack().context)
            try! getCoreDataStack().saveContext()
            currentPins.append(pin)
        }
    }
    
    //Load Saved Pin
    
    func preloadSavedPin() -> [Pin] {
        do {
            var pinArray:[Pin] = []
            let fetchedResultsController = getFetchedResultsController()
            try! fetchedResultsController.performFetch()
            let pinCount = try! fetchedResultsController.managedObjectContext.count(for: fetchedResultsController.fetchRequest)
            for index in 0..<pinCount {
                pinArray.append(fetchedResultsController.object(at: IndexPath(row: index, section: 0)) as! Pin)
            }
            return pinArray
        }
    }
    
    //Add Pin
    
    func addAnnotation(fromPoint: CGPoint) {
        
        let coordToAdd = mapView.convert(fromPoint, toCoordinateFrom: mapView)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordToAdd
        addCoreData(of: annotation)
        mapView.addAnnotation(annotation)
    }
    
    func addAnnotation(fromCoord: CLLocationCoordinate2D) {
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = fromCoord
        mapView.addAnnotation(annotation)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Add Annotation To Map
        
    }
    
} // End Class
