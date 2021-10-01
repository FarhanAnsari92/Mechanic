//
//  ShadowView.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 01/10/2021.
//

import UIKit

class ShadowView: UIView {

    var cornerRadius: CGFloat = 10
    override func layoutSubviews() {
        super.layoutSubviews()
        self.dropShadow()
        self.layer.cornerRadius = self.cornerRadius
    }

}
