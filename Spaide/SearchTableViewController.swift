//
//  SearchTableViewController.swift
//  Spaide
//
//  Created by Deborah on 9/4/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController, UISearchResultsUpdating {
    
    //Variables
    var array = []
    var searchController = UISearchController()
    var resultController = UITableViewController()

    override func viewDidLoad() {
        super.viewDidLoad()

        searchController = UISearchController(searchResultsController: resultController)
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchResultsUpdater = self
        resultController.tableView.delegate = self
        resultController.tableView.dataSource = self
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return cell
    }

} //End Class
