//
//  BannerViewController.swift
//  Spaide
//
//  Created by Deborah on 5/10/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import UIKit
import GoogleMobileAds
import Firebase
import FirebaseAuth
import AVFoundation

class HomeViewController: UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate {
    
    //Variables
    
    var soundPlayer = AVAudioPlayer()
    var recordedAudioURL: NSURL!
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    //Outlets
    
    @IBOutlet var bannerView: GADBannerView!
    @IBOutlet var playMessage: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Load Banner View

        loadBanner()
    }
    
    //Actions
    
    @IBAction func logoutAction(_ sender: Any) {
        
        FacebookAPI.sharedInstance().logoutUser(controller: self)
    }
    
    //Banner View Info

    func loadBanner() {
        
        print("Google Mobile Ads SDK version: " + GADRequest.sdkVersion())
        bannerView.adUnitID = "pub-9793810674761024"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
    }

}
