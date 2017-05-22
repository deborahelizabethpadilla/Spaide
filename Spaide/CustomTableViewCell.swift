//
//  CustomTableViewCell.swift
//  Spaide
//
//  Created by Deborah on 5/4/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    //Outets
    
    @IBOutlet var firstNameLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var limitationsLabel: UILabel!
    @IBOutlet var profileView: UIImageView!
    
    public func round() {

    let width = bounds.width < bounds.height ? bounds.width : bounds.height
    let mask = CAShapeLayer()
    mask.path = UIBezierPath(ovalInRect: CGRectMake(bounds.midX - width / 2, bounds.midY - width / 2, width, width)).CGPath
    self.layer.mask = mask
    }
    
    override func layoutSubviews() {
        profileView.round()
    }
}
