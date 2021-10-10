//
//  AccessoryBannerViewCollectionViewCell.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 10/10/2021.
//

import UIKit

class AccessoryBannerViewCollectionViewCell: UICollectionViewCell, AccessoryBannerViewDatasource {
    
    @IBOutlet weak var bannerView: AccessoryBanner!

    override func awakeFromNib() {
        super.awakeFromNib()
        bannerView.datasource = self
        bannerView.reloadData()
    }
    
    func imageURL(index: Int) -> Any {        
        let image = UIImage(named: "img_side_mirror")!
        return image
    }
    
    func numberOfImages() -> Int {
        return 3
    }

}
