//
//  SelectServicesTableViewCell.swift
//  Customer
//
//  Created by Mohammad Farhan on 10/8/21.
//

import UIKit

class SelectServicesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var radioView: AppRadioView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var parentView: UIView! {
        didSet {
            setParentViewBorder(isSelected: true)
        }
    }
    override var isSelected: Bool {
        didSet {
            radioView.isSelected = isSelected
            setParentViewBorder(isSelected: isSelected)
        }
    }
    
    func setParentViewBorder(isSelected: Bool) {
        parentView.layer.cornerRadius = 10
        parentView.layer.borderColor = isSelected == true ? UIColor.Theme.green.cgColor : UIColor(hexString: "B0B0B0").cgColor
        parentView.layer.borderWidth = 1
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
