//
//  AccessoriesCollectionViewCell.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 04/10/2021.
//

import UIKit

class AccessoriesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lblTitle: UILabel! {
        didSet{
            lblTitle.text = "aasd"
        }
    }
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblRating: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
