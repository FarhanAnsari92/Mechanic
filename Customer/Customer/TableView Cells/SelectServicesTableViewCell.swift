//
//  SelectServicesTableViewCell.swift
//  Customer
//
//  Created by Mohammad Farhan on 10/8/21.
//

import UIKit

class SelectServicesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var parentView: UIView! {
        didSet {
            parentView.layer.cornerRadius = 10
            parentView.layer.borderColor = UIColor.Theme.green.cgColor
            parentView.layer.borderWidth = 1
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
