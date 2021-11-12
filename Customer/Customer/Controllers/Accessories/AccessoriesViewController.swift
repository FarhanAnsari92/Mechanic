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
            
            collectionView.register(AutoPartsAndAccessoriesCollectionViewCell.nib, forCellWithReuseIdentifier: AutoPartsAndAccessoriesCollectionViewCell.identifier)
            collectionView.register(AccessoriesCollectionViewCell.nib, forCellWithReuseIdentifier: AccessoriesCollectionViewCell.identifier)
            collectionView.register(AccessoryBannerViewCollectionViewCell.nib, forCellWithReuseIdentifier: AccessoryBannerViewCollectionViewCell.identifier)
            
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Helmets"
        setupBackButton(color: .white)
    }
    
    @IBAction func filterButtonHandler(_ sender: UIButton) {
        let sb = UIStoryboard(storyboard: .accessories)
        let vc = sb.instantiateViewController(withIdentifier: FilterAccessoryViewController.storyboardIdentifier)
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

extension AccessoriesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AccessoryBannerViewCollectionViewCell.identifier, for: indexPath)
            return cell
        } else {
            // 2 liner item name will not work in iPhone 5s sized devices.
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AccessoriesCollectionViewCell.identifier, for: indexPath) as! AccessoriesCollectionViewCell
            if indexPath.row == 0 {
                cell.lblDescription.text = "Pack of 2 - Pro Biker Gloves MCS-01C + Winter Mask"
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let sb = UIStoryboard(storyboard: .accessories)
            let vc = sb.instantiateViewController(withIdentifier: AccessoriesDetailsViewController.storyboardIdentifier)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            let itemWidth = collectionView.bounds.width
            return CGSize(width: itemWidth, height: itemWidth * 0.4)
        } else {
            
            let numberOfItemsPerRow: CGFloat = 2
            let spacing: CGFloat = 20
            let totalSpace: CGFloat = (spacing * numberOfItemsPerRow) + 5
            let totalWidth = collectionView.frame.width - totalSpace
            let itemWidth = totalWidth / 2
            
            return CGSize(width: itemWidth, height: itemWidth * 1.3)
            
        }
        
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
    }
    
}
