//
//  BasketTableViewCell.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 09/10/2021.
//

import UIKit

class BasketTableViewCell: UITableViewCell {
    
    @IBOutlet weak var basketView: BasketView!

    override func awakeFromNib() {
        super.awakeFromNib()
        basketView.lblQuantity.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
