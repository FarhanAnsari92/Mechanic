//
//  MyVehicleTableViewCell.swift
//  Customer
//
//  Created by Mohammad Farhan on 10/2/21.
//

import UIKit

class MyVehicleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var parentView: UIView! {
        didSet {
            parentView.layer.cornerRadius = 14
            parentView.dropShadow()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
