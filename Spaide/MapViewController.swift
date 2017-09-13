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
        
        //Current User Location & Delegate
        
        self.mapView.showsUserLocation = true
        self.mapView.userTrackingMode = .follow
        self.mapView.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        self.locationManager.delegate = self
        
        let savedPins = preloadSavedPin()
        
        if savedPins != nil {
            
            currentPins = savedPins!
            
            //Add Annotation To Map
            
            for pin in currentPins {
                
                let coord = CLLocationCoordinate2D(latitude: pin.latitude, longitude: pin.longitude)
                addPinToMap(fromCoord: coord)
                
            }
        }

    }
    
    //Gesture Recognizer
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        gestureBegin = true
        return true
    }
    
    //Update User Location
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        var region = MKCoordinateRegion()
        region.span = MKCoordinateSpanMake(0.7, 0.7); //Zoom Distance
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
    
    //Select Annotation
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        
    }
    
    //Long Press Gesture Recognizer
    
    func longPressRecognizer(gestureRecognizer: UIGestureRecognizer) {
        
        let touchPoint = gestureRecognizer.location(in: self.mapView)
        let coordinate = mapView.convert(touchPoint, toCoordinateFrom: self.mapView)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
    }
    
    //Action
    
    @IBAction func responseLongTapAction(_ sender: Any) {
        if gestureBegin {
            let gestureRecognizer = sender as! UILongPressGestureRecognizer
            let gestureTouchLocation = gestureRecognizer.location(in: mapView)
            addPinToMap(fromPoint: gestureTouchLocation)
            gestureBegin = false
        }
    }
    //Add Core Data
    
    func addCoreData(of: MKAnnotation) {
        do {
            let coord = of.coordinate
            let pin = Pin(latitude: coord.latitude, longitude: coord.longitude, context: getCoreDataStack().context)
            try getCoreDataStack().saveContext()
            currentPins.append(pin)
        } catch {
            print("Add Core Data Failed!")
        }
    }
    
    //Add Pin
    
    func addPinToMap(fromPoint: CGPoint) {
        let coordToAdd = mapView.convert(fromPoint, toCoordinateFrom: mapView)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordToAdd
        addCoreData(of: annotation)
        mapView.addAnnotation(annotation)
    }
    
    func addPinToMap(fromCoord: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = fromCoord
        mapView.addAnnotation(annotation)
        
    }
    
} // End Class
