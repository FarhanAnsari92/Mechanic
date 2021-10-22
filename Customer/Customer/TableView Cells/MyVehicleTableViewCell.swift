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
    @IBOutlet weak var lblVehicleName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupBrandLabel()
        setupHorsePowerLabel()
        setupYearLabel()
        setupCityLabel()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func set(data: GetVehicleModel) {
        lblVehicleName.text = data.vehicle?.name ?? ""
        setupBrandLabel(data.brand?.title ?? "")
        setupHorsePowerLabel(data.horsePower ?? "")
        setupCityLabel(data.city?.name ?? "")
        setupYearLabel(data.year?.description ?? "")
    }
    
    private func setupBrandLabel(_ brandName: String = "") {
        
        let plainText = "Brand: "
        let tappableText = brandName
        
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
    
    private func setupHorsePowerLabel(_ horsePowerName: String = "") {
        
        let plainText = "Horse Power: "
        let tappableText = horsePowerName
        
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
    
    private func setupYearLabel(_ year: String = "") {
        
        let plainText = "Year: "
        let tappableText = year
        
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
    
    private func setupCityLabel(_ city: String = "") {
        
        let plainText = "City: "
        let tappableText = city
        
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
