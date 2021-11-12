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
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func set(data: AddressModel) {
        lblAddress.text = data.title ?? "NA"
        lblDetailedAddress.text = data.address ?? "NA"
    }
    
}
