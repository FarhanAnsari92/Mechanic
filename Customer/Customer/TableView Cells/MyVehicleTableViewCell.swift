//
//  MyVehicleTableViewCell.swift
//  Customer
//
//  Created by Mohammad Farhan on 10/8/21.
//

import UIKit

class MyVehicleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblBrand: UILabel!
    @IBOutlet weak var lblYear: UILabel!
    @IBOutlet weak var lblHousePower: UILabel!
    @IBOutlet weak var lblCity: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupBrandLabel()
        setupHousePowerLabel()
        setupYearLabel()
        setupCityLabel()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    
    private func setupBrandLabel() {
        
        let plainText = "Brand: "
        let tappableText = "Honda"
        
        let plainAttributedString = NSMutableAttributedString(string: plainText, attributes: [.foregroundColor: UIColor(hexString: "252525"), .font: UIFont.Poppins(.light, size: 12)])
        
        let attributedLinkString = NSMutableAttributedString(
            string: tappableText,
            attributes:[
                .foregroundColor: UIColor(hexString: "252525"),
                .font: UIFont.Poppins(.bold, size: 12)
            ]
        )
        let fullAttributedString = NSMutableAttributedString()
        fullAttributedString.append(plainAttributedString)
        fullAttributedString.append(attributedLinkString)
        lblBrand.isUserInteractionEnabled = false
        lblBrand.attributedText = fullAttributedString

    }
    
    private func setupHousePowerLabel() {
        
        let plainText = "House Power: "
        let tappableText = "125CC"
        
        let plainAttributedString = NSMutableAttributedString(string: plainText, attributes: [.foregroundColor: UIColor(hexString: "252525"), .font: UIFont.Poppins(.light, size: 12)])
        
        let attributedLinkString = NSMutableAttributedString(
            string: tappableText,
            attributes:[
                .foregroundColor: UIColor(hexString: "252525"),
                .font: UIFont.Poppins(.bold, size: 12)
            ]
        )
        let fullAttributedString = NSMutableAttributedString()
        fullAttributedString.append(plainAttributedString)
        fullAttributedString.append(attributedLinkString)
        lblHousePower.isUserInteractionEnabled = false
        lblHousePower.attributedText = fullAttributedString

    }
    
    private func setupYearLabel() {
        
        let plainText = "Year: "
        let tappableText = "2021"
        
        let plainAttributedString = NSMutableAttributedString(string: plainText, attributes: [.foregroundColor: UIColor(hexString: "252525"), .font: UIFont.Poppins(.light, size: 12)])
        
        let attributedLinkString = NSMutableAttributedString(
            string: tappableText,
            attributes:[
                .foregroundColor: UIColor(hexString: "252525"),
                .font: UIFont.Poppins(.bold, size: 12)
            ]
        )
        let fullAttributedString = NSMutableAttributedString()
        fullAttributedString.append(plainAttributedString)
        fullAttributedString.append(attributedLinkString)
        lblYear.isUserInteractionEnabled = false
        lblYear.attributedText = fullAttributedString

    }
    
    private func setupCityLabel() {
        
        let plainText = "City: "
        let tappableText = "Karachi"
        
        let plainAttributedString = NSMutableAttributedString(string: plainText, attributes: [.foregroundColor: UIColor(hexString: "252525"), .font: UIFont.Poppins(.light, size: 12)])
        
        let attributedLinkString = NSMutableAttributedString(
            string: tappableText,
            attributes:[
                .foregroundColor: UIColor(hexString: "252525"),
                .font: UIFont.Poppins(.bold, size: 12)
            ]
        )
        let fullAttributedString = NSMutableAttributedString()
        fullAttributedString.append(plainAttributedString)
        fullAttributedString.append(attributedLinkString)
        lblCity.isUserInteractionEnabled = false
        lblCity.attributedText = fullAttributedString

    }
    
}
