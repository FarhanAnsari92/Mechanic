//
//  BuyAccessoriesConfirmationBasketTableViewCell.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 08/10/2021.
//

import UIKit

class BuyAccessoriesConfirmationBasketTableViewCell: UITableViewCell {
    
    @IBOutlet weak var stackViewBasket: UIStackView!
    @IBOutlet weak var txtPromo: UITextField! {
        didSet {
            txtPromo.layer.cornerRadius = 5
            txtPromo.backgroundColor = UIColor(hexString: "E9E9E9")
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        (0..<2).forEach { i in
            let basketView = BasketView()
            basketView.heightAnchor.constraint(equalToConstant: 90).isActive = true
            if i == 0 {
                basketView.lblName.text = "Long Name Long Name Long Name Long Name Long Name Long Name Long Name Long Name Long Name Long Name Long Name Long Name Long Name Long Name"
            }
            stackViewBasket.addArrangedSubview(basketView)
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
