//
//  CategoryCollectionViewCell.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 20/11/2021.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imgCategory: UIImageView!
    @IBOutlet weak var btnCategory: UIButton!
    
    var categoryCompletion: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func set(data: CategoryModel) {
        if let url = data.iconUrl {
            ImageCacheManager().loadImage(imageView: self.imgCategory, url: url, placeholderImage: nil)
        }
        btnCategory.setTitle(data.name ?? "NA", for: .normal)
    }
    
    @IBAction func categoryButtonHandler(_ sender: UIButton) {
        categoryCompletion?()
    }

}
