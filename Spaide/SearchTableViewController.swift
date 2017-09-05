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
    var array = ["One", "Two", "Three"]
    var filterArray = [String]()
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
        filterArray = array.filter({ (array:String) -> Bool in
            if array.contains(searchController.searchBar.text!) {
                return true
            } else {
                return false
            }
        })
        
        resultController.tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == resultController.tableView {
            return filterArray.count
        } else {
            return array.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if tableView == resultController.tableView {
        cell.textLabel?.text = filterArray[indexPath.row]
    } else {
         cell.textLabel?.text = array[indexPath.row]
    }
        return cell
        
    }

} //End Class
