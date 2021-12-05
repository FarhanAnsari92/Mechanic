//
//  DashboardJobTableViewCell.swift
//  Mechanic
//
//  Created by BYKEA - Hadi Ali on 02/12/2021.
//

import UIKit

class DashboardJobTableViewCell: UITableViewCell {
    
    @IBOutlet weak var parentView: UIView! {
        didSet {
            parentView.layer.cornerRadius = 14
            parentView.dropShadow()
        }
    }
    @IBOutlet weak var imageParentView: UIView! {
        didSet {
            imageParentView.layer.cornerRadius = imageParentView.bounds.height / 2
            imageParentView.layer.borderWidth = 1
            imageParentView.layer.borderColor = UIColor(hexString: "D8D8D8").cgColor
        }
    }
    @IBOutlet weak var lblJobTitle: UILabel! {
        didSet {
            lblJobTitle.text = "You have new pick up task on list"
        }
    }
    @IBOutlet weak var lblVehicleName: UILabel!
    @IBOutlet weak var lblVehicleModel: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblDateTime: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func set(data: BookingHistoryModel) {
        self.lblVehicleName.text = data.brandName
        self.lblVehicleModel.text = data.vehicleTitle
        if let address = data.address {
            self.lblAddress.isHidden = false
            self.lblAddress.text = address
        } else {
            self.lblAddress.isHidden = true
        }
        if let createdAt = data.createdAt {
            self.lblDateTime.isHidden = false
            self.lblDateTime.text = createdAt
        } else {
            self.lblDateTime.isHidden = true
        }
        
        
    }
}
