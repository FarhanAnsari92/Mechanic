//
//  BuyAccessoriesConfirmationTableViewCell.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 08/10/2021.
//

import UIKit

class BuyAccessoriesConfirmationAddressTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblDetailedAddress: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        lblAddress.text = "Gulzar-e-Hijri"
        lblDetailedAddress.text = "Kaneez Fatima Society, Scheme 33, Karachi"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
