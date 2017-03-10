//
//  ContactsViewController.swift
//  Spaide
//
//  Created by Deborah on 3/10/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import UIKit

class ContactsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, FetchData {
    
    //Outlets
    
    @IBOutlet weak var myTable: UITableView!
    
    //Variables
    
    private let CELL_ID = "Cell"
    
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
        
        cell.textLabel?.text = "This Works!"
        
        return cell
    }
}
