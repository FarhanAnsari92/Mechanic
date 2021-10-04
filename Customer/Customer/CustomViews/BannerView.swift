//
//  BannerView.swift
//  BannerApp
//
//  Created by Mohammad Farhan on 9/27/19.
//  Copyright © 2019 Mohammad Farhan. All rights reserved.
//

import UIKit
import SDWebImage

protocol BannerViewDatasource: NSObjectProtocol {
    func imageURL(index:Int) -> Any
    func numberOfImages() -> Int
}

protocol BannerViewDelegate: NSObjectProtocol {
    func bannerView(_ bannerView: BannerView, didSelectItemAt index: Int)
}

class BannerView: UIView {
    
    @IBOutlet weak var contentView: UIView?
    @IBOutlet weak var collectionView: UICollectionView?
    @IBOutlet weak var pageControl: UIPageControl? {
        didSet {
            pageControl?.addTarget(self, action: #selector(self.pageControlHandler(_:)), for: .valueChanged)
        }
    }
    var urls: [URL] = [URL]()
    var images: [UIImage] = [UIImage]()
    weak var datasource: BannerViewDatasource?
    weak var delegate: BannerViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("BannerView", owner: self, options: nil)
        guard let contentView = self.contentView else {
            return
        }
        self.addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        self.collectionView?.register(BannerCollectionViewCell.nib, forCellWithReuseIdentifier: BannerCollectionViewCell.id)
        
        self.reloadData()
    }
    
    func reloadData() {
        guard let datasource = self.datasource else {
            return
        }
        
        self.urls.removeAll()
        self.images.removeAll()
        for i in 0..<datasource.numberOfImages() {
            if let url = datasource.imageURL(index: i) as? URL {
                self.urls.append(url)
            } else if let image = datasource.imageURL(index: i) as? UIImage {
                self.images.append(image)
            }
        }
        self.pageControl?.numberOfPages = datasource.numberOfImages()
        self.collectionView?.reloadData()
    }
    
    @objc func pageControlHandler(_ sender: UIPageControl) {
        self.collectionView?.scrollToItem(at: IndexPath(item: sender.currentPage, section: 0), at: .centeredHorizontally, animated: true)
    }
    
}

extension BannerView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return max(urls.count, images.count)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCollectionViewCell.id, for:
            indexPath) as! BannerCollectionViewCell
        if self.urls.count > 0 {
            cell.imageView.sd_setImage(with: self.urls[indexPath.row])
        } else if self.images.count > 0 {
            cell.imageView.image = self.images[indexPath.row]
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.frame.size
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
        self.pageControl?.currentPage = page
    }
    
}
