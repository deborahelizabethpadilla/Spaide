//
//  LocationSearchTableViewController.swift
//  Spaide
//
//  Created by Deborah on 8/28/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import UIKit
import MapKit

class LocationSearchTable: UITableViewController {
    
    //Variables

    var matchingItems:[MKMapItem] = []
    var mapView: MKMapView? = nil
}

extension LocationSearchTable : UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
    }
}

extension LocationSearchTable : UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
    }
}
