//
//  NibDesignable.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 22/09/2021.
//

import UIKit

class NibDesignable: UIView {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        nibSetup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        nibSetup()
    }
}

extension NibDesignable
{
    func nibSetup() {
        
        let view = loadViewFromNib()
        
        addSubview(view)
    
       view.translatesAutoresizingMaskIntoConstraints = false
       view.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
       view.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
       view.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
       view.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let nibView = nib.instantiate(withOwner: self, options: nil).first as! UIView
        
        return nibView
    }
}

