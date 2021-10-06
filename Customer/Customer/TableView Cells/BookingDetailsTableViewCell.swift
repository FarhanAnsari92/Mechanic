//
//  BookingDetailsTableViewCell.swift
//  Customer
//
//  Created by Mohammad Farhan on 10/6/21.
//

import UIKit

class BookingDetailsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var topLine: UIView!
    @IBOutlet weak var bottomLine: UIView!
    @IBOutlet weak var lblLeft: UILabel!
    @IBOutlet weak var lblRight: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
