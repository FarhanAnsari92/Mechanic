//
//  SelectWorkshopTableViewCell.swift
//  Customer
//
//  Created by Mohammad Farhan on 10/10/21.
//

import UIKit

class SelectWorkshopTableViewCell: UITableViewCell {
    
    @IBOutlet weak var radioView: AppRadioView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblkm: UILabel!
    @IBOutlet weak var parentView: UIView! {
        didSet {
            setParentViewBorder(isSelected: true)
        }
    }
    
    override var isSelected: Bool{
        didSet {
            radioView.isSelected = isSelected
            setParentViewBorder(isSelected: isSelected)
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
    func set(data: WorkShopModel) {
        self.lblTitle.text = data.name ?? "NA"
        self.lblDesc.text = data.address ?? "NA"
        self.lblkm.text = "3.0 KM" // will be calculated from current coordinate
        self.isSelected = data.isSelected
    }
    
    func setParentViewBorder(isSelected: Bool) {
        parentView.layer.cornerRadius = 10
        parentView.layer.borderColor = isSelected == true ? UIColor(hexString: "BEC5D1").cgColor : UIColor(hexString: "B0B0B0").cgColor
        parentView.layer.borderWidth = 1
    }
    
}
