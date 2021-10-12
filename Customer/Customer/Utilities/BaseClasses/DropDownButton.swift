//
//  DropDownButton.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 13/10/2021.
//

import UIKit

class DropDownButton: UIButton {

    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(hexString: "BEC5D1").cgColor
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
