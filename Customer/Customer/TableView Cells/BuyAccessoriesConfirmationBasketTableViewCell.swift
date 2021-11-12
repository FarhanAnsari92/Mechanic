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
    
    @IBOutlet weak var lblSubTotal: UILabel!
    @IBOutlet weak var lblDeliveryCharges: UILabel!
    @IBOutlet weak var lblGrandTotal: UILabel!        

    override func awakeFromNib() {
        super.awakeFromNib()
//        (0..<2).forEach { i in
//            let basketView = BasketView()
//            basketView.stepper.isHidden = true
//            basketView.heightAnchor.constraint(equalToConstant: 90).isActive = true
//            if i == 0 {
//                basketView.lblName.text = "Long Name Long Name Long Name Long Name Long Name Long Name Long Name Long Name Long Name Long Name Long Name Long Name Long Name Long Name"
//            }
//            stackViewBasket.addArrangedSubview(basketView)
//        }
        self.lblDeliveryCharges.text = Constants.Order.displayOrderCharges
    }
    
    func set(data: [ProductModel]) {
        var total: Int = 0
        (0..<data.count).forEach { i in
            let basketView = BasketView()
            basketView.stepper.isHidden = true
            let product = data[i]
            let price = product.price ?? 0
            let quantity = product.quantity
            let _total = price * quantity
            total += _total
            basketView.set(data: product)
            basketView.heightAnchor.constraint(equalToConstant: 90).isActive = true
            stackViewBasket.addArrangedSubview(basketView)
        }
        let formattedTotal = Helper.formatCurrency(value: total) ?? "0"
        self.lblSubTotal.text = "Rs. " + formattedTotal
        
        let grandTotal = total + Constants.Order.orderCharges
        let formattedGrandTotal = Helper.formatCurrency(value: grandTotal) ?? "0"
        
        self.lblGrandTotal.text = formattedGrandTotal
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
