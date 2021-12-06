//
//  AppButton.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 30/09/2021.
//

import UIKit

class AppButton: UIButton {
    
    @IBInspectable var buttonColor: UIColor = UIColor.Theme.green {
        didSet {
            self.backgroundColor = buttonColor
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.backgroundColor = buttonColor
        self.titleLabel?.font = UIFont.Poppins(.light, size: 14)
        self.setTitleColor(UIColor.white, for: .normal)
        self.layer.cornerRadius = 10
        self.clipsToBounds = true        
    }

}
