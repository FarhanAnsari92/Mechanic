//
//  AutoPartsAndAccessoriesTableViewCell.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 03/10/2021.
//

import UIKit

class AutoPartsAndAccessoriesTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func autoPartsButtonHandler(_ sender: UIButton) {
        print("autoPartsButtonHandler")
    }
    
    @IBAction func accessoriesButtonHandler(_ sender: UIButton) {
        print("accessoriesButtonHandler")
    }
    
}
