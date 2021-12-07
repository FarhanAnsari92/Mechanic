//
//  TitleHeaderView.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 07/12/2021.
//

import UIKit

class TitleHeaderView: UIView {
    
    @IBOutlet weak var lblTitle: UILabel!
    
    static var loadNib: TitleHeaderView {
        
        return Bundle.main.loadNibNamed("TitleHeaderView", owner: self, options: nil)?.first as! TitleHeaderView
        
    }
    

}
