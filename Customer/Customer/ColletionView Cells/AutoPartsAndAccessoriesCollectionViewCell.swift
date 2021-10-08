//
//  AutoPartsAndAccessoriesCollectionViewCell.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 04/10/2021.
//

import UIKit

class AutoPartsAndAccessoriesCollectionViewCell: UICollectionViewCell {
    
    var autoPartsCompletion: (() -> Void)?
    var accessoriesCompletion: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func autoPartsButtonHandler(_ sender: UIButton) {
        autoPartsCompletion?()
    }
    
    @IBAction func accessoriesButtonHandler(_ sender: UIButton) {
        accessoriesCompletion?()
    }

}
