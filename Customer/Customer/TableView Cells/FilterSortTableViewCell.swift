//
//  FilterSortTableViewCell.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 10/10/2021.
//

import UIKit

class FilterSortTableViewCell: UITableViewCell {
    
    @IBOutlet weak var radioOutsiderView: UIView! {
        didSet {
            radioOutsiderView.layer.cornerRadius = radioOutsiderView.frame.width / 2
            radioOutsiderView.layer.borderWidth = 1
            radioOutsiderView.layer.borderColor = UIColor.Theme.green.cgColor
        }
    }
    @IBOutlet weak var radioInnerView: UIView! {
        didSet {
            radioInnerView.layer.cornerRadius = radioInnerView.frame.width / 2
            radioInnerView.backgroundColor = UIColor.Theme.green
        }
    }
    
    override var isSelected: Bool {
        didSet {
            radioInnerView.isHidden = !isSelected
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
