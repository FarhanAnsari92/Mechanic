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
    
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    
    var product: ProductModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = product?.name ?? "NA"
        setupBackButton(color: .white)
        
        self.lblPrice.text =  product?.displayPrice
        self.lblDescription.text = product?.description ?? ""
        self.lblRating.text = (product?.rating ?? 0.0).description
    }
    
    @IBAction func buyNowButtonHandler(_ sender: UIButton) {
        let sb = UIStoryboard(storyboard: .accessories)
        let vc = sb.instantiateViewController(withIdentifier: BuyAccessoriesConfirmationViewController.storyboardIdentifier) as! BuyAccessoriesConfirmationViewController        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func addToCartButtonHandler(_ sender: UIButton) {
        if let prod = self.product {
            ProductCart.shared.add(product: prod)
        }
    }

}

extension AccessoriesDetailsViewController: AccessoryBannerViewDatasource {
    
    func imageURL(index: Int) -> Any {
        let url = product?.images?[index].url
        return url
    }
    
    func numberOfImages() -> Int {
        return product?.images?.count ?? 0
    }
    
}
