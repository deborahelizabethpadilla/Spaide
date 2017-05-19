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
import FirebaseDatabase
import FirebaseAuth

class HomeViewController: UIViewController {
    
    //Firebase
    
    var refUsers = Database.database().reference().child("Profile")
    
    //Outlets
    
    @IBOutlet var bannerView: GADBannerView!
    
    
    
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
        
        bannerView = GADBannerView(adSize: kGADAdSizeLargeBanner)
        self.view.addSubview(bannerView)
        bannerView.adUnitID = "pub-9793810674761024"
        bannerView.rootViewController = self
        bannerView.load(GADRequest)
        
    }
    
    

}
