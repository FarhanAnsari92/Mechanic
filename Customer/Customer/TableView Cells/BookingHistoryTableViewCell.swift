//
//  BookingHistoryTableViewCell.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 02/10/2021.
//

import UIKit

class BookingHistoryTableViewCell: UITableViewCell {
    
    static let height: CGFloat = 100.0
    var viewDetailsCompletion: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func viewDetailsButtonHandler(_ sender: UIButton) {
        viewDetailsCompletion?()
    }
    
}
