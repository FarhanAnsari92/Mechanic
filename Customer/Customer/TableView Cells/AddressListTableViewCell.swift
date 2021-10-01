//
//  AddressListTableViewCell.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 29/09/2021.
//

import UIKit

class AddressListTableViewCell: UITableViewCell {
    
    static let height: CGFloat = 60
    @IBOutlet weak var imgPin: UIImageView!
    @IBOutlet weak var imgEdit: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
