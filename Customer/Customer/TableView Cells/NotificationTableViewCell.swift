//
//  NotificationTableViewCell.swift
//  Customer
//
//  Created by Mohammad Farhan on 10/6/21.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDesc: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        lblDesc.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco"
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
