//
//  CategoryListCollectionViewCell.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 20/11/2021.
//

import UIKit

class CategoryListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
            
            collectionView.register(CategoryCollectionViewCell.nib, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
            
        }
    }
    var categoryCompletion: ((Int?) -> Void)?
    var categories: [CategoryModel]?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func set(data: [CategoryModel]) {
        self.categories = data
        self.collectionView.reloadData()
    }

}

extension CategoryListCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.categories?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as! CategoryCollectionViewCell
        let ctgry = self.categories?[indexPath.row]
        cell.categoryCompletion = { [weak self] in
            self?.categoryCompletion?(ctgry?.id)
        }
        if let category = ctgry {
            cell.set(data: category)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.width / 2
        let height = collectionView.frame.height
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
