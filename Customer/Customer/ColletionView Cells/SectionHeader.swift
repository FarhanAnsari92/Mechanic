//
//  SectionHeader.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 04/10/2021.
//

import UIKit

class SectionHeader: UICollectionReusableView {
    
    static let identifier: String = "Header"
    
     var label: UILabel = {
        let label: UILabel = UILabel()
        label.textColor = UIColor(hexString: "1F2937")
        label.font = UIFont.Poppins(.semiBold, size: 18)
        label.sizeToFit()
        return label
     }()
    
    func configure() {
        addSubview(label)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds
        label.frame.origin.x = 20
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
