//
//  AppRadioView.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 08/10/2021.
//

import UIKit

class AppRadioView: NibDesignable {
    
    @IBOutlet weak var imgTick: UIImageView!
    @IBOutlet weak var deselectView: UIView! {
        didSet {
            deselectView.layer.cornerRadius = 10
            deselectView.layer.borderColor = UIColor.white.cgColor
        }
    }
    
    var isSelected: Bool = true {
        didSet {
            imgTick.isHidden = !isSelected
            deselectView.isHidden = isSelected
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
