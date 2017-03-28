//
//  InputController.swift
//  Spaide
//
//  Created by Deborah on 3/22/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import UIKit
import ChameleonFramework
import ImageRow
import Eureka

class InputController: UIViewController, FormViewController {
    
    //Outlets & Actions

    override func viewDidLoad() {
        super.viewDidLoad()
        
      //Set Background
        
      view.backgroundColor = FlatGreenDark()
        
      //Row With Eureka
        
        form +++ Section()
            <<< ImageRow() { row in
                row.title = "Image Row 1"
                row.sourceTypes = [.PhotoLibrary, .SavedPhotosAlbum]
                row.clearAction = .yes(style: UIAlertActionStyle.destructive)
            }
            +++
            Section()
            <<< ImageRow() {
                $0.title = "Image Row 2"
                $0.sourceTypes = .PhotoLibrary
                $0.clearAction = .no
                }
                .cellUpdate { cell, row in
                    cell.accessoryView?.layer.cornerRadius = 17
                    cell.accessoryView?.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
            }
            +++
            Section()
            <<< ImageRow() {
                $0.title = "Image Row 3"
                $0.sourceTypes = [.PhotoLibrary, .SavedPhotosAlbum]
                $0.clearAction = .yes(style: .default)
        }
    }
    
    
}
