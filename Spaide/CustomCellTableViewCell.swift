//
//  customCell.swift
//  Spaide
//
//  Created by Deborah on 3/15/17.
//  Copyright © 2017 Deborah. All rights reserved.
//

import UIKit

class customCell: UITableViewCell {
    
    //Outlets
    
    @IBOutlet var firstName: UILabel!
    @IBOutlet var cityState: UILabel!
    @IBOutlet var imageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
