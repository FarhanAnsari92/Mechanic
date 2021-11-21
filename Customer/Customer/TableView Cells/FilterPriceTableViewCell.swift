//
//  FilterPriceTableViewCell.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 10/10/2021.
//

import UIKit
import NHRangeSlider

class FilterPriceTableViewCell: UITableViewCell {
    
    @IBOutlet weak var txtMin: UITextField! {
        didSet {
            txtMin.layer.borderColor = UIColor(hexString: "BEC5D1").cgColor
            txtMin.layer.borderWidth = 1
            txtMin.layer.cornerRadius = 10
        }
    }
    
    @IBOutlet weak var txtMax: UITextField! {
        didSet {
            txtMax.layer.borderColor = UIColor(hexString: "BEC5D1").cgColor
            txtMax.layer.borderWidth = 1
            txtMax.layer.cornerRadius = 10
        }
    }
    
    @IBOutlet weak var priceRange: NHRangeSliderView!

    override func awakeFromNib() {
        super.awakeFromNib()
        priceRange.minimumValue = 0
        priceRange.maximumValue = 100000
        priceRange.lowerValue = 0
        priceRange.upperValue =  100000
        priceRange.thumbBorderWidth = 0
        priceRange.thumbTintColor = UIColor.Theme.green
        priceRange.trackHighlightTintColor = UIColor.Theme.green
        priceRange.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension FilterPriceTableViewCell: NHRangeSliderViewDelegate {
    
    func sliderValueChanged(slider: NHRangeSlider?) {
        let lower: Int = Int(slider?.lowerValue ?? 0)
        let upper: Int = Int(slider?.upperValue ?? 0)
        self.txtMin.text = lower.description
        self.txtMax.text = upper.description
    }
    
}
