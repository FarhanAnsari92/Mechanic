//
//  SingleSelectionView.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 10/10/2021.
//

import UIKit

class SingleSelectionView: NibDesignable {
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            
            collectionView.register(ButtonCollectionViewCell.nib, forCellWithReuseIdentifier: ButtonCollectionViewCell.identifier)
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        
    }

}

extension SingleSelectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ButtonCollectionViewCell.identifier, for: indexPath) as! ButtonCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let numberOfItemsPerRow: CGFloat = 2
        let spacing: CGFloat = 15 // dynamic
        let totalSpace: CGFloat = (spacing * numberOfItemsPerRow) // + 5
        let totalHeight = collectionView.frame.height - totalSpace
        let itemHeight = totalHeight / 2
        
        return CGSize(width: 80, height: itemHeight)
        
        
//        let height = (collectionView.frame.height) / 2
//        return CGSize(width: 80, height: height)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
    }
    
}
