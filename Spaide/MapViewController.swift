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
        
    }
    

} //End Class
