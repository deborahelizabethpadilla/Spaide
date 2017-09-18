//
//  MapViewController.swift
//  Spaide
//
//  Created by Deborah on 9/18/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class MapViewController: UIViewController, MKMapViewDelegate, UIGestureRecognizerDelegate {
    
    //Outelts.

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var deletePins: UILabel!
    
    //Variables.
    
    var gestureBegin: Bool = false
    var editMode: Bool = false
    var currentPins:[Pin] = []
    
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
        
        //Nav Bar.
        
        setBarButtonRight()
        
        //Label Design.
        
        deletePins.layer.cornerRadius = 15
        
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
    
    //Edit.
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        
        super.setEditing(editing, animated: animated)
        deletePins.isHidden = !editing
        editMode = editing
    }

} // End Class
