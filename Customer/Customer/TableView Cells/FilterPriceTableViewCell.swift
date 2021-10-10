//
//  FilterPriceTableViewCell.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 10/10/2021.
//

import UIKit

class FilterPriceTableViewCell: UITableViewCell {
    
    @IBOutlet weak var txtMin: UITextField! {
        didSet {
            txtMin.layer.borderColor = UIColor(hexString: "BEC5D1").cgColor
            txtMin.layer.borderWidth = 1
            txtMin.layer.cornerRadius = 10
        }
    }
    
    @IBOutlet weak var txtMax: UITextField! {
        didSet {
            txtMax.layer.borderColor = UIColor(hexString: "BEC5D1").cgColor
            txtMax.layer.borderWidth = 1
            txtMax.layer.cornerRadius = 10
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
