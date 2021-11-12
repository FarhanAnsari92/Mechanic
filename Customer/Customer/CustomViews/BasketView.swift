//
//  BasketView.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 08/10/2021.
//

import UIKit

class BasketView: NibDesignable {
    
    @IBOutlet weak var imgParentView: UIView! {
        didSet {
            imgParentView.layer.cornerRadius = 10
            imgParentView.layer.borderWidth = 1
            imgParentView.layer.borderColor = UIColor.fill(white: 198).cgColor
        }
    }
    @IBOutlet weak var imgViewAccessory: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblQuantity: UILabel!
    @IBOutlet weak var stepper: BaseStepper!

    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func set(data: ProductModel) {
        self.stepper.isHidden = true
        self.lblName.text = data.name ?? "NA"
        
        if let urlStr = data.images?.first?.mediaUrl {
            ImageCacheManager().loadImage(imageView: self.imgViewAccessory, url: urlStr, placeholderImage: nil)
        }
    }

}
