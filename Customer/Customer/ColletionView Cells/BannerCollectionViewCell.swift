//
//  BannerCollectionViewCell.swift
//  BannerApp
//
//  Created by Mohammad Farhan on 9/28/19.
//  Copyright © 2019 Mohammad Farhan. All rights reserved.
//

import UIKit

class BannerCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            imageView.layer.cornerRadius = 20
        }
    }
    
    static let id: String = "BannerCollectionViewCellID"
    static let nib: UINib = UINib(nibName: "BannerCollectionViewCell", bundle: nil)
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
