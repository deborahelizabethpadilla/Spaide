//
//  MapViewController.swift
//  Spaide
//
//  Created by Deborah on 8/28/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, UISearchBarDelegate {
    
    //Variables
    
    var searchController:UISearchController!
    let locationManager = CLLocationManager()

    @IBOutlet weak var mapView: MKMapView!
    @IBAction func showSearchBar(_ sender: Any) {
        searchController = UISearchController(searchResultsController: nil)
        searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchBar.delegate = self
        present(searchController, animated: true, completion: nil)
    }
    
    @IBAction func currentLocation(_ sender: Any) {
        
        mapView.showsUserLocation = true
        mapView.setUserTrackingMode(.follow, animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }

} //End Class

