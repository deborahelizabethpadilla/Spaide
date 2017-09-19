//
//  MapViewController.swift
//  Spaide
//
//  Created by Deborah on 9/18/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import CoreData

class MapViewController: UIViewController, MKMapViewDelegate, UIGestureRecognizerDelegate, CLLocationManagerDelegate {
    
    //Outelts.

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var deletePins: UILabel!
    
    //Variables.
    
    var gestureBegin: Bool = false
    var editMode: Bool = false
    var currentPins:[Pin] = []
    let locationManager = CLLocationManager()
    
    //Core Data.
    
    func getCoreDataStack() -> CoreDataStack {
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        return delegate.stack
    }
    
    //Fetch Requests.
    
    func getFetchResultsController() -> NSFetchedResultsController<NSFetchRequestResult> {
        
        let stack = getCoreDataStack()
        let fr = NSFetchRequest<NSFetchRequestResult>(entityName: "Pin")
        fr.sortDescriptors = []
        
        return NSFetchedResultsController(fetchRequest: fr, managedObjectContext: stack.context, sectionNameKeyPath: nil, cacheName: nil)
    }
    
    //Load Saved Pin.
    
    func preloadSavedPin() -> [Pin]? {
        
        do {
            
            var pinArray:[Pin] = []
            let fetchedResultsController = getFetchResultsController()
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
    
    //View DL.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Current Location Info.
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        //Nav Bar.
        
        setBarButtonRight()
        
        //Label Design.
        
        deletePins.layer.cornerRadius = 25
        deletePins.clipsToBounds = true
        
        //Load Pins.

        let savedPins = preloadSavedPin()
        
        if savedPins != nil {
            
            currentPins = savedPins!
            
            //Add Annotation To Map
            
            for pin in currentPins {
                
                let coord = CLLocationCoordinate2D(latitude: pin.latitude, longitude: pin.longitude)
                addAnnotationToMap(fromCoord: coord)
                
            }
        }
    }
    
    //Bar Button Item.
    
    func setBarButtonRight() {
        
        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    //Gesture Recognizer.
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        gestureBegin = true
        return true
    }
    
    //Map View Function.
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        if !editMode {
            
            //Go To Segue VC.
            
            performSegue(withIdentifier: "PinSegue", sender: view.annotation?.coordinate)
            mapView.deselectAnnotation(view.annotation, animated: false)
            
        } else {
            
            //Remove Annotation.
            
            removeCoreData(of: view.annotation!)
            mapView.removeAnnotation(view.annotation!)
        }
    }
    
    //Actions.
    
    @IBAction func responseLongTap(_ sender: Any) {
        
        if gestureBegin {
            
            let gestureRecognizer = sender as! UILongPressGestureRecognizer
            let gestureTouchLocation = gestureRecognizer.location(in: mapView)
            addAnnotationToMap(fromPoint: gestureTouchLocation)
            gestureBegin = false
        }
    }
    
    //Add Pin.
    
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
    
    //Add Core Data.
    
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
    
    //Delete Core Data.
    
    func removeCoreData(of: MKAnnotation) {
        
        let coord = of.coordinate
        
        for pin in currentPins {
            
            if pin.latitude == coord.latitude && pin.longitude == coord.longitude {
                
                do {
                    
                    getCoreDataStack().context.delete(pin)
                    try getCoreDataStack().saveContext()
                    
                } catch {
                    
                    print("Remove Core Data Failed!")
                }
                break
            }
        }
    }
    
    //Custom Annotation.
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if !(annotation is MKPointAnnotation) {
            return nil
        }
        
        let annotationIdentifer = "AnnotationIdentifier"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifer)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifer)
            annotationView?.annotation = annotation
            
            
        }
        
        let pinImage = UIImage(named: "wheelchair")
        annotationView?.image = pinImage
        
        return annotationView
    }
    
    //User Location Map View.
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations[0]
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
        mapView.setRegion(region, animated: true)
        
        print(location.altitude)
        print(location.speed)
        
        self.mapView.showsUserLocation = true
    }
    
    //Edit.
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        
        super.setEditing(editing, animated: animated)
        deletePins.isHidden = !editing
        editMode = editing
    }

} // End Class
