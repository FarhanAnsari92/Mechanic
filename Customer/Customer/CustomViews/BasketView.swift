//
//  BasketView.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 08/10/2021.
//

import UIKit

class BasketView: NibDesignable, BaseStepperDelegate {
    
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
    
    var stepperComplition: ((Bool, Int) -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.stepper.delegate = self
    }
    
    func set(data: ProductModel) {        
        self.lblName.text = data.name ?? "NA"
        
        if let urlStr = data.images?.first?.mediaUrl {
            ImageCacheManager().loadImage(imageView: self.imgViewAccessory, url: urlStr, placeholderImage: nil)
        }
        self.lblPrice.text = data.displayPrice
        self.lblQuantity.text = data.displayQuantity
        stepper.maxValue = data.stockAvailable ?? 0
        stepper.value = data.quantity
    }
    
    func stepperValueChnaged(_ sender: BaseStepper, isIncremented: Bool) {
        stepperComplition?(isIncremented, sender.value)
    }

}
