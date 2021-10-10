//
//  BookingDetailsHeader.swift
//  Customer
//
//  Created by Mohammad Farhan on 10/6/21.
//

import UIKit

class BookingDetailsHeader: UIView {
    
    @IBOutlet weak var lblHeaderTitle: UILabel!
    @IBOutlet weak var imgIndicator: UIImageView!
    @IBOutlet weak var headerBtn: UIButton!
    
    var completion: (() -> Void)?
    
    var isExpand: Bool = false {
        didSet {
            imgIndicator.image = UIImage(named: isExpand ? "ic_arrow_up" : "ic_arrow_down")
        }
    }
    var isClickable: Bool = false {
        didSet {
            headerBtn.isHidden = !isClickable
            imgIndicator.isHidden = !isClickable
        }
    }
    
    @IBAction func headerButtonHandler(_ sender: UIButton) {
        completion?()
    }

    static var loadNib: BookingDetailsHeader {
        
        return Bundle.main.loadNibNamed("BookingDetailsHeader", owner: self, options: nil)?.first as! BookingDetailsHeader
        
    }
    

}
