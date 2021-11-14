//
//  OrderHistoryTableViewCell.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 26/09/2021.
//

import UIKit

class OrderHistoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var parentView: UIView! {
        didSet {
            parentView.layer.cornerRadius = 14
            parentView.dropShadow()
        }
    }
    @IBOutlet weak var imageParentView: UIView! {
        didSet {
            imageParentView.layer.cornerRadius = 14
            imageParentView.layer.borderWidth = 1
            imageParentView.layer.borderColor = UIColor(hexString: "D8D8D8").cgColor
        }
    }
    @IBOutlet weak var imgOrder: UIImageView!
    @IBOutlet weak var lblOrderName: UILabel!
    @IBOutlet weak var lblQuantity: UILabel!
    @IBOutlet weak var lblCreatedAt : UILabel!
    @IBOutlet weak var lblPrice: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func set(data: OrderModel) {
        let product = data.products?.first
        let orderInfo = product?.orderInfo
        self.lblQuantity.text = orderInfo?.displayQuantity
        self.lblPrice.text = data.displaySubTotal
        self.lblOrderName.text = product?.name ?? "NA"
        self.lblCreatedAt.text = data.displayFormattedDate
        let url = product?.images?.first?.mediaUrl ?? ""
        ImageCacheManager().loadImage(imageView: self.imgOrder, url: url, placeholderImage: nil)
    }
    
}
