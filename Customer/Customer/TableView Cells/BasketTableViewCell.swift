//
//  BasketTableViewCell.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 09/10/2021.
//

import UIKit

class BasketTableViewCell: UITableViewCell {
    
    @IBOutlet weak var basketView: BasketView!
    var stepperComplition: ((Bool, Int) -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        basketView.lblQuantity.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func set(data: ProductModel) {
        basketView.stepper.isHidden = false
        basketView.set(data: data)
        basketView.stepperComplition = { [weak self] (isIncremented, value) in
            self?.stepperComplition?(isIncremented, value)
        }
    }
    
}
