//
//  AddNewVehicleViewController.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 13/10/2021.
//

import UIKit
import RSSelectionMenu

class AddNewVehicleViewController: HomeBaseViewController {
    
    @IBOutlet weak var lblBrand: UILabel!
    @IBOutlet weak var lblCity: UILabel!
    
    var cities: [CityModel]?
    var brands: [BrandModel]?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add Vehicle"
        setupBackButton(color: .white)
        City.shared.getCities { [weak self] cities in
            self?.cities = cities
        }
        Brand.shared.getBrands { [weak self] brands in
            self?.brands = brands
        }
    }
    
    @IBAction func brandButtonHandler(_ sender: UIButton) {
        guard let brands = self.brands else { return }
        let brandMenu = RSSelectionMenu(dataSource: brands ) { (cell, item, indexPath) in
            cell.textLabel?.text = item.title ?? "NA"
        }
        brandMenu.setSelectedItems(items: brands) { (item, index, isSelected, selectedItems) in
            self.lblBrand.text = selectedItems.first?.title ?? ""
        }
        
        brandMenu.show(style: .alert(title: "brands", action: "Done", height: Double(view.frame.height) / 3), from: self)
    }
    
    @IBAction func cityButtonHandler(_ sender: UIButton) {
        
        guard let cities = self.cities else { return }
        let citiesMenu = RSSelectionMenu(dataSource: cities) { (cell, item, indexPath) in
            cell.textLabel?.text = item.name ?? "NA"
        }
        
        citiesMenu.setSelectedItems(items: cities) { (item, index, isSelected, selectedItems) in
            self.lblCity.text = selectedItems.first?.name ?? ""
        }
        
        citiesMenu.show(style: .alert(title: "Cities", action: "Done", height: Double(view.frame.height) / 3), from: self)
    }

}
