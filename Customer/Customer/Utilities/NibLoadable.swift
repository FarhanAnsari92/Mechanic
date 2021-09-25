//
//  NibLoadable.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 22/09/2021.
//

import UIKit

protocol NibLoadable {
    static var nib: UINib { get }
    static var identifier: String { get }
}

extension NibLoadable where Self: UITableViewCell {
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
}

extension NibLoadable where Self: UICollectionViewCell {
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
}
