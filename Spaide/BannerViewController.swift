//
//  BannerViewController.swift
//  Spaide
//
//  Created by Deborah on 5/10/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import UIKit
import GoogleMobileAds

class BannerViewController: UIViewController {
    
    //Outlets
    
    @IBOutlet var bannerView: GADBannerView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Load Banner View

        loadBanner()
    }
    
    //Banner View Info

    func loadBanner() {
        
        print("Google Mobile Ads SDK version: " + GADRequest.sdkVersion())
        bannerView.adUnitID = "pub-9793810674761024"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
    }

}
