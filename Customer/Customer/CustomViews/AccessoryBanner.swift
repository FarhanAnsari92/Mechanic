//
//  AccessoryBanner.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 10/10/2021.
//

import UIKit
import AdvancedPageControl

protocol AccessoryBannerViewDatasource: NSObjectProtocol {
    func imageURL(index:Int) -> Any
    func numberOfImages() -> Int
}

protocol AccessoryBannerViewDelegate: NSObjectProtocol {
    func bannerView(_ bannerView: AccessoryBanner, didSelectItemAt index: Int)
}

class AccessoryBanner: NibDesignable {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: AdvancedPageControlView!
    
    var urls: [URL] = [URL]()
    var images: [UIImage] = [UIImage]()
    weak var datasource: AccessoryBannerViewDatasource?
    weak var delegate: AccessoryBannerViewDelegate?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        commonInit()
    }
    
    private func commonInit() {
        
        self.collectionView?.register(BannerCollectionViewCell.nib, forCellWithReuseIdentifier: BannerCollectionViewCell.id)
        self.collectionView?.delegate = self
        self.collectionView?.dataSource = self
        self.reloadData()
    }
    
    func reloadData() {
        guard let datasource = self.datasource else {
            return
        }
        
        let totalImages = datasource.numberOfImages()
        
        self.urls.removeAll()
        self.images.removeAll()
        for i in 0..<datasource.numberOfImages() {
            if let url = datasource.imageURL(index: i) as? URL {
                self.urls.append(url)
            } else if let image = datasource.imageURL(index: i) as? UIImage {
                self.images.append(image)
            }
        }
//        self.pageControl?.numberOfPages = datasource.numberOfImages()
        setNumberOfPagesInBanner(pages: totalImages)
        self.collectionView?.reloadData()
    }
    
    func setNumberOfPagesInBanner(pages: Int) {
        let indidatorDrawer = ExtendedDotDrawer(
            numberOfPages: pages,
            height: 8,
            width: 8,
            space: 4,
            raduis: 4,
            indicatorColor: UIColor.Theme.green,
            dotsColor: UIColor.Theme.green.withAlphaComponent(0.4),
            isBordered: false,
            borderWidth: 0
        )
        self.pageControl.drawer = indidatorDrawer
    }

}

extension AccessoryBanner: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return max(urls.count, images.count)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCollectionViewCell.id, for:
            indexPath) as! BannerCollectionViewCell
        cell.imageView.contentMode = .center
        if self.urls.count > 0 {
            cell.imageView.sd_setImage(with: self.urls[indexPath.row])
        } else if self.images.count > 0 {
            cell.imageView.image = self.images[indexPath.row]
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.bannerView(self, didSelectItemAt: indexPath.row)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let pageWidth = scrollView.frame.size.width
        let fractionalPage = Float(scrollView.contentOffset.x / pageWidth)
        let page = Int(roundf(fractionalPage))
        print("page - ", page)
//        self.pageControl?.currentPage = page
        self.pageControl.setPage(page)
    }
    
}

