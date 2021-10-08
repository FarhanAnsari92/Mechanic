//
//  BuyAccessoriesConfirmationPaymentMethodTableViewCell.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 08/10/2021.
//

import UIKit

class BuyAccessoriesConfirmationPaymentMethodTableViewCell: UITableViewCell {
    
    @IBOutlet weak var creditRadioApp: AppRadioView!
    @IBOutlet weak var cashRadioApp: AppRadioView!

    override func awakeFromNib() {
        super.awakeFromNib()
        creditRadioApp.isSelected = false
        cashRadioApp.isSelected = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
