//
//  BuyAccessoriesConfirmationTableViewCell.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 08/10/2021.
//

import UIKit

class ConfirmBookingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var lblTitle: UILabel!
    
    var changeCompletion: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
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
    
    @IBAction func changeButtonHandler(_ sender: UIButton) {
        changeCompletion?()
    }
    
}
