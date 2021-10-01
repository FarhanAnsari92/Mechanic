//
//  TrackingBookingNumberTableViewCell.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 02/10/2021.
//

import UIKit

class TrackingBookingNumberTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblBookingNumber: UILabel!
    @IBOutlet weak var lblDescription: UILabel! {
        didSet {
            lblDescription.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation"
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
