//
//  OTPTextField.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 25/09/2021.
//

import UIKit

class OTPTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        layer.cornerRadius = 10
//        layer.borderWidth = 0.2
        backgroundColor = UIColor.white
        dropShadow()
//        font = UIFont.Poppins(UIFont.FontType.semiBold, size: 29)
        textAlignment = .center
    }
}
