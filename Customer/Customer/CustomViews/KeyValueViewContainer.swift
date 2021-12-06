//
//  KeyValueViewContainer.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 05/12/2021.
//

import UIKit

class KeyValueViewContainer: NibDesignable {
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnChange: UIButton!
    
    func setData(section: Section) {
        lblTitle.text = section.title
        (0..<section.details.count).forEach({ i in
            let item = section.details[i]
            
            let kvo = KeyValueView()
//            kvo.heightAnchor.constraint(equalToConstant: 30).isActive = true
            kvo.topSeparator.isHidden = item.hideTopSeparator
            kvo.bottomSeparator.isHidden = item.hideBottomSeparator
            kvo.lblKey.text = item.leftTitle
            kvo.lblValue.text = item.rightTitle
            stackView.addArrangedSubview(kvo)
            
        })
        
    }


}
