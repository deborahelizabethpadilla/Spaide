//
//  AudioAPI.swift
//  Spaide
//
//  Created by Deborah on 5/11/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class RecordSendPlayMessage : UserTableViewController, AVAudioRecorderDelegate {

    //Variables
    
    
    
    //Functions
    

    
    
    //Shared Instance
    
    class func sharedInstance() -> RecordSendPlayMessage {
        
        struct Singleton {
            
            static var sharedInstance = RecordSendPlayMessage()
        }
        return Singleton.sharedInstance
    }
    
}
