//
//  ContactsViewController.swift
//  Spaide
//
//  Created by Deborah on 3/10/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import UIKit
import FirebaseAnalytics

class ContactsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, FetchData {
    
    //Outlets
    
    //Variables
    
    private let CELL_ID = "customCell"
    private let CHAT_SEGUE = "chatSegue"
    
    private var contacts = [Contact]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Call Data To View
        
        DataBase.Instance.delegate = self
        DataBase.Instance.getContacts()
    }
    
    //Data Received Function
    
    func dataReceived(contacts: [Contact]) {
        
        self.contacts = contacts
        
        //Get Name Of Current User
        
        firstName.reloadInputViews()
        cityState.reloadInputViews()
        
    }
    
    //Table View Functions
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return contacts.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_ID, for: indexPath)
        
        cell.textLabel?.text = contacts[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: CHAT_SEGUE, sender: nil)
    }
}
