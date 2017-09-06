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
import GeoFire

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    //Variables
    var ref:DatabaseReference!
    var geoFire:GeoFire!
    let locationManager = CLLocationManager()
    var currentPins:[Pin] = []
    
    //Outlets & Actions
    @IBOutlet weak var mapView: MKMapView!
    @IBAction func addLocation(_ sender: Any) {
        //Present VC To Add Info
        
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
    
    //Map View Function
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        if !editMode {
            
            performSegue(withIdentifier: "PinPhotos", sender: view.annotation?.coordinate)
            
            mapView.deselectAnnotation(view.annotation, animated: false)
            
        } else {
            
            removeCoreData(of: view.annotation!)
            
            mapView.removeAnnotation(view.annotation!)
        }
    }
    
    //Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "PinPhotos" {
            
            let destination = segue.destination as! PhotosViewController
            let coord = sender as! CLLocationCoordinate2D
            destination.coordinateSelected = coord
            
            for pin in currentPins {
                
                if pin.latitude == coord.latitude && pin.longitude == coord.longitude {
                    
                    destination.coreDataPin = pin
                    break
                }
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Track Mode
        mapView.userTrackingMode = MKUserTrackingMode.follow
        
        //Pins
        
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
    
    //Display Alert
    
    func displayAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            self.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }

} //End Class
