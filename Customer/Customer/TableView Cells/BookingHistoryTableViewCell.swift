//
//  BookingHistoryTableViewCell.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 02/10/2021.
//

import UIKit

class BookingHistoryTableViewCell: UITableViewCell {
    
    static let height: CGFloat = 100.0
    
    @IBOutlet weak var lblBookingId: UILabel!
    @IBOutlet weak var lblVehicle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblCharges: UILabel!
    
    var viewDetailsCompletion: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func viewDetailsButtonHandler(_ sender: UIButton) {
        viewDetailsCompletion?()
    }
    
    func set(data: BookingHistoryModel) {        
        self.lblBookingId.text = data.displayBookingId
        self.lblVehicle.text = data.vehicleName
        self.lblCharges.text = data.charges
        self.lblDate.text = data.bookingCreatedAt
    }
    
}
