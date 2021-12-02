//
//  AccessoriesViewController.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 08/10/2021.
//

import UIKit

class AccessoriesViewController: HomeBaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            
            collectionView.register(AccessoriesCollectionViewCell.nib, forCellWithReuseIdentifier: AccessoriesCollectionViewCell.identifier)
            collectionView.register(AccessoryBannerViewCollectionViewCell.nib, forCellWithReuseIdentifier: AccessoryBannerViewCollectionViewCell.identifier)
            
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }

    let imageCacheManager: ImageCacheManager = ImageCacheManager()
    var products: [ProductModel]?
    
    var categoryId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Products"
        setupBackButton(color: .white)
        
        var parameters = [String:String]()
        if let catId = categoryId {
            parameters["category_ids"] = catId.description
        }
        getProducts(parameters: parameters)
        
    }
    
    func getProducts(parameters: [String:String]? = nil) {
//        var parameters = [String:String]()
//        if text.count > 0 {
//            parameters["keyword"] = text
//        }
        APIClient.callApi(api: .products, parameters: parameters, method: .get, view: self.view) { [weak self] data in
            guard let self = self else { return }
            if let dictionary = data {
                if let productResponseModel = ObjectMapperManager<ProductResponseModel>().map(dictionary: dictionary) {
                    
                    if let products = productResponseModel.data?.products, products.count > 0 {
                        self.products = products
                        self.collectionView.reloadData()
                    } else {
                        Helper.showMessage(text: "No Products Found.")
                    }
                }
            }
        }
    }
    
    @IBAction func filterButtonHandler(_ sender: UIButton) {
        let sb = UIStoryboard(storyboard: .accessories)
        let vc = sb.instantiateViewController(withIdentifier: FilterAccessoryViewController.storyboardIdentifier)
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

extension AccessoriesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.products?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {        // 2 liner item name will not work in iPhone 5s sized devices.
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AccessoriesCollectionViewCell.identifier, for: indexPath) as! AccessoriesCollectionViewCell
        if let product = self.products?[indexPath.row] {
            cell.set(data: product, imageCacheManager: imageCacheManager)
        }
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sb = UIStoryboard(storyboard: .accessories)
        let vc = sb.instantiateViewController(withIdentifier: AccessoriesDetailsViewController.storyboardIdentifier)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            
        let numberOfItemsPerRow: CGFloat = 2
        let spacing: CGFloat = 20
        let totalSpace: CGFloat = (spacing * numberOfItemsPerRow) + 5
        let totalWidth = collectionView.frame.width - totalSpace
        let itemWidth = totalWidth / 2
        
        return CGSize(width: itemWidth, height: itemWidth * 1.3)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
    }
    
}
