//
//  LeftMenuProfilePictureTableViewCell.swift
//  Customer
//
//  Created by Muhammad Farhan on 1/2/21.
//

import UIKit

class LeftMenuTableViewCell: UITableViewCell {
    
    @IBOutlet weak var upperLine: UIView!
    @IBOutlet weak var lowerLine: UIView!
    @IBOutlet weak var imageVU: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var indicatorImage: UIImageView! {
        didSet {            
            indicatorImage.tintColor = UIColor.fill(red: 72, green: 100, blue: 31)
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
