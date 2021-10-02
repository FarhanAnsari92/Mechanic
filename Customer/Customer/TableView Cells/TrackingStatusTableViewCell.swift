//
//  TrackingStatusTableViewCell.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 02/10/2021.
//

import UIKit

class TrackingStatusTableViewCell: UITableViewCell {
    
    let selectedColor: UIColor = UIColor(hexString: "252525")
    let deselectedColor: UIColor = UIColor.fill(white: 212)
    
    @IBOutlet weak var imgTick: UIImageView!
    @IBOutlet weak var deselectView: UIView! {
        didSet {
            deselectView.layer.cornerRadius = 10
            deselectView.layer.borderColor = UIColor.white.cgColor
        }
    }
    @IBOutlet weak var upperLine: UIView!
    @IBOutlet weak var lowerLine: UIView!
    
    @IBOutlet weak var lblStatus: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
