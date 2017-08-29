//
//  MapViewController.swift
//  Spaide
//
//  Created by Deborah on 8/28/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, UISearchBarDelegate, CLLocationManagerDelegate {
    
    //Variables
    var searchController:UISearchController!
    var locationManager = CLLocationManager()
    var resultSearchController:UISearchController? = nil
    
    @IBOutlet var mapView: MKMapView!
    @IBAction func searchCurrentLocation(_ sender: Any) {
        //Show User Location, Zoom & Track
        mapView.showsUserLocation = true
        mapView.setUserTrackingMode(.follow, animated: true)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Set Search Bar
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        let locationSearchTable = storyboard!.instantiateViewController(withIdentifier: "LocationSearchTable") as! LocationSearchTable
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.searchResultsUpdater = locationSearchTable
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Find Ability Friendly Places"
        navigationItem.titleView = resultSearchController?.searchBar
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        resultSearchController?.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
        locationSearchTable.mapView = mapView
        
    }
    

} //End Class

extension MapViewController {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegion(center: location.coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error)")
    }
    
} //End Class
