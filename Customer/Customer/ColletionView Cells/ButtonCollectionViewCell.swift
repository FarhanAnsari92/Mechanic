//
//  ButtonCollectionViewCell.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 10/10/2021.
//

import UIKit

class ButtonCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var btn: UIButton!{
        didSet{
            
            btn.backgroundColor = UIColor.Theme.green
            btn.layer.cornerRadius = 10
            
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
