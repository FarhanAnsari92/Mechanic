//
//  AccessoriesDetailsViewController.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 09/10/2021.
//

import UIKit

class AccessoriesDetailsViewController: HomeBaseViewController {
    
    @IBOutlet weak var pricePrentView: UIView! {
        didSet {
            pricePrentView.dropShadow()
        }
    }
    
    @IBOutlet weak var bannerView: BannerView! {
        didSet {
            bannerView.datasource = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "HELMET BURAAK"
        setupBackButton(color: .white)
        bannerView.reloadData()
    }

}

extension AccessoriesDetailsViewController: BannerViewDatasource {
    
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
