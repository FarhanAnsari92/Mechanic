//
//  HistoryTableViewCell.swift
//  Customer
//
//  Created by Mohammad Farhan on 10/2/21.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var parentView: UIView! {
           didSet {
               parentView.layer.cornerRadius = 14
               parentView.dropShadow()
           }
       }
    
    @IBOutlet weak var btnViewDetailsl: UIButton! {
           didSet {
               btnViewDetailsl.layer.cornerRadius = 10
               btnViewDetailsl.backgroundColor = UIColor.Theme.green
           }
       }
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    
    
}
