//
//  AccessoriesCollectionViewCell.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 04/10/2021.
//

import UIKit

class AccessoriesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var imgProduct: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func set(data: ProductModel, imageCacheManager: ImageCacheManager) {
        if let urlStr = data.images?.first?.mediaUrl {
            imageCacheManager.loadImage(imageView: self.imgProduct, url: urlStr, placeholderImage: nil)
        }
        self.lblPrice.text =  data.displayPrice
        self.lblDescription.text = data.description ?? ""
        self.lblRating.text = (data.rating ?? 0.0).description
    }

}
