//
//  BannerViewCollectionViewCell.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 05/10/2021.
//

import UIKit

class BannerViewCollectionViewCell: UICollectionViewCell, BannerViewDatasource {
        
    @IBOutlet weak var bannerView: BannerView!

    override func awakeFromNib() {
        super.awakeFromNib()
        bannerView.datasource = self
        bannerView.reloadData()
    }
    
    func imageURL(index: Int) -> Any {
        let imageName = "banner\(index+1)"
        print("imageName - ", imageName)
        let image = UIImage(named: imageName)!
        return image
    }
    
    func numberOfImages() -> Int {
        return 3
    }

}
