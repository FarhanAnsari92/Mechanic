//
//  ProductDetailsAndRatingsView.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 09/10/2021.
//

import UIKit

class ProductDetailsAndRatingsView: NibDesignable {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var btnDetails: UIButton!
    @IBOutlet weak var btnReview: UIButton!
    
    lazy var productDetailsView: ProductDetailsView? = {
        let _productDetailsView = ProductDetailsView()
        return _productDetailsView
    }()
    
    lazy var productReviewsView: ProductReviewsView? = {
        let _productReviewsView = ProductReviewsView()
        return _productReviewsView
    }()
    
    var shouldShowDetails: Bool = true {
        didSet {
            if shouldShowDetails {
                btnDetails.setTitleColor(UIColor.Theme.green, for: .normal)
                btnReview.setTitleColor(UIColor(hexString: "D8D8D8"), for: .normal)
                productDetailsView?.frame = self.contentView.bounds
                productReviewsView?.removeFromSuperview()
                self.contentView.addSubview(productDetailsView!)
            } else {
                btnDetails.setTitleColor(UIColor(hexString: "D8D8D8"), for: .normal)
                btnReview.setTitleColor(UIColor.Theme.green, for: .normal)
                productReviewsView?.frame = self.contentView.bounds
                productDetailsView?.removeFromSuperview()
                self.contentView.addSubview(productReviewsView!)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        shouldShowDetails = true
    }
    
    @IBAction func productDetailsButtonHandler(_ sender: UIButton) {
        shouldShowDetails = true
    }
    
    @IBAction func productReviewsButtonHandler(_ sender: UIButton) {
        shouldShowDetails = false
    }

}
