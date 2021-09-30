//
//  AppButton.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 30/09/2021.
//

import UIKit

class AppButton: UIButton {

    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.backgroundColor = UIColor.Theme.green
        self.titleLabel?.font = UIFont.Poppins(.light, size: 14)
        self.setTitleColor(UIColor.white, for: .normal)
        self.layer.cornerRadius = 10
        self.clipsToBounds = true        
    }

}
