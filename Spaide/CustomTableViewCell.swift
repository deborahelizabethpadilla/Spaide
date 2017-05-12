//
//  CustomTableViewCell.swift
//  Spaide
//
//  Created by Deborah on 5/4/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import UIKit
import AVFoundation

class CustomTableViewCell: UITableViewCell {
    
    //Variables
    
    var soundRecorder = AVAudioRecorder()
    var fileName = "audioFile.m4a"

    
    @IBOutlet var firstNameLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var limitationsLabel: UILabel!
    @IBOutlet var profileView: UIImageView!
    @IBOutlet var recordMessage: UIButton!
    
    
    @IBAction func recordMessageAction(_ sender: Any) {
        
        
    }

}
