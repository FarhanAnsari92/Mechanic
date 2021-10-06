//
//  ChatReceiverTableViewCell.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 07/10/2021.
//

import UIKit

class ChatReceiverTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblSender: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var bubbleView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.setNeedsLayout()
        self.contentView.layoutIfNeeded()
        bubbleView.roundCorners(topLeft: 5, topRight: 15, bottomLeft: 15, bottomRight: 15)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
