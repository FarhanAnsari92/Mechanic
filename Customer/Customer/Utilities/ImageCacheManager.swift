//
//  ImageCacheManager.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 11/11/2021.
//

import UIKit
import SDWebImage

protocol ImageCacheable {
    func loadImage(imageView: UIImageView, url: String, placeholderImage: UIImage?)
}

class SDWebImageCacheManager: ImageCacheable {
    
    func loadImage(imageView: UIImageView, url: String, placeholderImage: UIImage?) {
        guard let imageURL: URL = URL(string: url) else {
            print("------- Unable to find proper image url.")
            return
        }
        imageView.sd_setImage(with: imageURL, placeholderImage: placeholderImage, options: .highPriority, context: nil)
    }

}

class ImageCacheManager {
    
    private var cache: ImageCacheable
    
    init() {
        self.cache = SDWebImageCacheManager()
    }
    
    func loadImage(imageView: UIImageView, url: String, placeholderImage: UIImage?) {
        cache.loadImage(imageView: imageView, url: url, placeholderImage: placeholderImage)
    }
    
}
