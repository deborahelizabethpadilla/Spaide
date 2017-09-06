//
//  MapViewController.swift
//  Spaide
//
//  Created by Deborah on 9/5/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import UIKit
import MapKit
import Firebase
import FirebaseDatabase
import GeoFire

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    //Variables
    var ref:DatabaseReference!
    var geoFire:GeoFire!
    let locationManager = CLLocationManager()
    
    //Outlets & Actions
    @IBOutlet weak var mapView: MKMapView!
    @IBAction func addLocation(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Delegate
        mapView.delegate = self
        
        //Track Mode
        mapView.userTrackingMode = MKUserTrackingMode.follow
        
        //Firebase & GeoFire
        ref = Database.database().reference()
        geoFire = GeoFire(firebaseRef: ref)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
    
    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
        
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
