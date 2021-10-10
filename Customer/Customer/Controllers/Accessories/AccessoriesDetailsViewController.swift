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
    
    @IBOutlet weak var bannerView: AccessoryBanner! {
        didSet {
            bannerView.datasource = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "HELMET BURAAK"
        setupBackButton(color: .white)
    }
    
    @IBAction func buyNowButtonHandler(_ sender: UIButton) {
        let sb = UIStoryboard(storyboard: .accessories)
        let vc = sb.instantiateViewController(withIdentifier: BuyAccessoriesConfirmationViewController.storyboardIdentifier)
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

extension AccessoriesDetailsViewController: AccessoryBannerViewDatasource {
    
    func imageURL(index: Int) -> Any {        
        let image = UIImage(named: "img_side_mirror")!
        return image
    }
    
    func numberOfImages() -> Int {
        return 3
    }
    
}
