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

class MapViewController: UIViewController, MKMapViewDelegate, UIGestureRecognizerDelegate, CLLocationManagerDelegate {
    
    //Variables
    
    var locationManager = CLLocationManager()
    var currentPins:[Pin] = []
    var gestureBegin: Bool = false
    
    //Outlets
    
    @IBOutlet weak var mapView: MKMapView!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Current User Location & Delegate
        
        self.mapView.showsUserLocation = true
        self.mapView.userTrackingMode = .follow
        self.mapView.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        self.locationManager.delegate = self
        
        //Long Press Gesture
        
        let longPressRecogniser = UILongPressGestureRecognizer(target: self, action: #selector(MapViewController.longPressRecognizer(gestureRecognizer:)))
        
        longPressRecogniser.minimumPressDuration = 1.5
        mapView.addGestureRecognizer(longPressRecogniser)
        
        //Add Pins To Map
        
        addSavedPinsToMap()

    }
    
    //Update User Location
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        var region = MKCoordinateRegion()
        region.span = MKCoordinateSpanMake(0.7, 0.7); //Zoom
        let coordinate = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude:  userLocation.coordinate.longitude)
        region.center = coordinate
        mapView.setRegion(region, animated: true)
    }
    
    //Add Custom Annotation
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let customPinID = "customPinIdentifier"
        var customPin: MKAnnotationView?
        if let dequedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: customPinID) {
            customPin = dequedAnnotationView
            customPin?.annotation = annotation
        } else {
            customPin = MKAnnotationView(annotation: customPin as? MKAnnotation, reuseIdentifier: customPinID)
            customPin?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        
        if let customPin = customPin {
            customPin.canShowCallout = true
            customPin.image = UIImage(named: "wheelchair")
        }
        
        return customPin
    }
    
    //Long Press Gesture Recognizer
    
    func longPressRecognizer(gestureRecognizer: UIGestureRecognizer) {
        //Gesture Recognizer State
        if gestureBegin {
            return
        } else {
            if gestureRecognizer.state != .ended {
                return
            }
        }
        //Touch Map
        let touchPoint = gestureRecognizer.location(in: self.mapView)
        //Convert Point To Coordinate
        let touchMapCoordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        //Init Annotation
        let annotation = MKPointAnnotation()
        annotation.coordinate = touchMapCoordinate
        //Init Pin
        let newPin = Pin(latitude: annotation.coordinate.latitude, longitude: annotation.coordinate.longitude, context: getCoreDataStack().context)
        //Save To Core Data
        try! getCoreDataStack().saveContext()
        //Add Pin To Array
        currentPins.append(newPin)
        //Add Pin To Map
        mapView.addAnnotation(annotation)
        
        
    }

    //Add Pins
    
    func addSavedPinsToMap() {
        currentPins = fetchAllPins()
        print("Pins Count In Core Data Is \(currentPins.count)")
        for pin in currentPins {
            let annotation = MKPointAnnotation()
            annotation.coordinate = pin.coordinate
            mapView.addAnnotation(annotation)
        }
    }
    
    //Fetch All Pins
    
    func fetchAllPins() -> [Pin] {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Pin")
        do {
            return try getCoreDataStack().context.fetch(fetchRequest) as! [Pin]
        } catch {
            print("Error In Fetch!")
            return [Pin]()
        }
        
    }
    
    //Select Pin
    
} // End Class
