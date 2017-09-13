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

class MapViewController: UIViewController, MKMapViewDelegate {
    
    //Variables
    
    var locationManager = CLLocationManager()
    var currentPins = [Pin]()
    var gestureBegin: Bool = false
    
    var sharedContext: NSManagedObjectContext {
        return CoreDataStack.sharedInstance().managedObjectContext
    }
    
    //Fetch All Pins
    
    func fetchAllPins() -> [Pin] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Pin")
        do {
            return try sharedContext.fetch(fetchRequest) as! [Pin]
        } catch {
            print("Error In Fetch!")
            return [Pin]()
        }
    }
    
    //Outlets
    
    @IBOutlet weak var mapView: MKMapView!
    
    //Core Dat
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(MapViewController.longPressGesture(longPress:)))
        longPressRecognizer.minimumPressDuration = 1.5
        mapView.addGestureRecognizer(longPressRecognizer)
        
        self.mapView.delegate = self
        
        addSavedPinsToMap()
        
    }
    
    //Add Saved Pin To Map
    
    func addSavedPinsToMap() {
        currentPins = fetchAllPins()
        print("Pins Count in Core Data Is \(currentPins.count)")
        
        for currentPin in currentPins {
            let annotation = MKPointAnnotation()
            annotation.coordinate = currentPin.coordinate
            mapView.addAnnotation(annotation)
        }
    }
    
    //Long Press Gesture Recognizer
    
    func longPressGesture(longPress: UIGestureRecognizer) {
        //Take Point
        let touchPoint = longPress.location(in: self.mapView)
        
        //Convert Point To Coordinate From View
        let touchMapCoordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        
        //Init Annotation
        let annotation = MKPointAnnotation()
        annotation.coordinate = touchMapCoordinate
        
        //Init New Pin
        let newPin = Pin(latitude: annotation.coordinate.latitude, longitude: annotation.coordinate.longitude, context: sharedContext)
        
        //Save To Core Data
        CoreDataStack.sharedInstance().saveContext()
        
        //Adding New Pin To Pins Array
        currentPins.append(newPin)
        
        //Add New Pin To Map
        mapView.addAnnotation(annotation)
    }
    
} // End Class
