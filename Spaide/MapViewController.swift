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
    
    //Outlets
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Current User Location & Delegate
        
        self.mapView.showsUserLocation = true
        self.mapView.userTrackingMode = .follow
        self.mapView.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        self.locationManager.delegate = self
        

    }
    
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
    
    //Add Core Data
    
    func addCoreData(of: MKAnnotation) {
        
    }
    
    //Add Pin
    
    func addPinToMap(fromPoint: CGPoint) {
        
    }
    
} // End Class
