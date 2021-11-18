//
//  OrderInfoView.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 19/11/2021.
//

import UIKit

class OrderInfoView: UIView {
    
    @IBOutlet weak var shadowView: UIView! {
        didSet {
            shadowView.layer.cornerRadius = 14
            shadowView.dropShadow()
        }
    }
    
    @IBOutlet weak var lblOrderReference: UILabel!
    @IBOutlet weak var lblOrderStatus: UILabel!
    @IBOutlet weak var lblCreatedAt : UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    
    var tapCompletion: (() -> Void)?

    static var loadNib: OrderInfoView {
        
        return Bundle.main.loadNibNamed("OrderInfoView", owner: self, options: nil)?.first as! OrderInfoView
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapView))
        tapGesture.numberOfTapsRequired = 1
        self.addGestureRecognizer(tapGesture)
        self.isUserInteractionEnabled = true
    }
    
    @objc func tapView() {
        tapCompletion?()
    }
    
    func set(data: OrderModel) {
        self.lblOrderReference.text = data.displayOrderId
        self.lblOrderStatus.text = data.orderStatus ?? ""
        self.lblCreatedAt.text = data.displayFormattedDate
        self.lblPrice.text = data.displaySubTotal
    }

}
