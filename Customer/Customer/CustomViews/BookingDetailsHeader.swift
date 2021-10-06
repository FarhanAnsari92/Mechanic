//
//  BookingDetailsHeader.swift
//  Customer
//
//  Created by Mohammad Farhan on 10/6/21.
//

import UIKit

class BookingDetailsHeader: UIView {
    
    @IBOutlet weak var lblHeaderTitle: UILabel!

    static var loadNib: BookingDetailsHeader {
        
        return Bundle.main.loadNibNamed("BookingDetailsHeader", owner: self, options: nil)?.first as! BookingDetailsHeader
        
    }
    

}
