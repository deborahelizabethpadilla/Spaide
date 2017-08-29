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
        //Show User Location & Track
        mapView.showsUserLocation = true
        mapView.setUserTrackingMode(.follow, animated: true)
    }
    @IBAction func showSearchBar(_ sender: Any) {
        //Present Search Bar
        searchController = UISearchController(searchResultsController: nil)
        searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchBar.delegate = self
        present(searchController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Send Results To Table VC
        let locationSearchTable = storyboard!.instantiateViewController(withIdentifier: "LocationSearchTable") as! LocationSearchTable
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.searchResultsUpdater = locationSearchTable as UISearchResultsUpdating
        locationSearchTable.mapView = mapView
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //Dismiss Nav Bar & Show Design
        searchBar.resignFirstResponder()
        searchBar.placeholder = "Search Places"
        dismiss(animated: true, completion: nil)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            //Zoom Location
            if let location = locations.first {
                let span = MKCoordinateSpanMake(0.05, 0.05)
                let region = MKCoordinateRegion(center: location.coordinate, span: span)
                mapView.setRegion(region, animated: true)
            }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        //Failed To Find Location
        print("error:: \(error)")
    }
    

} //End Class
