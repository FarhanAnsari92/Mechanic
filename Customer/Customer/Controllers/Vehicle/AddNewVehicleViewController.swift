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
    @IBOutlet weak var lblYear: UILabel!
    @IBOutlet weak var lblHP: UILabel!
    @IBOutlet weak var lblModel : UILabel!
    
    var cities: [CityModel]?
    var brands: [BrandModel]?
    var  model : [VehicleModel]?
    var years: [String] = [String]()
    var horsePower: [String] = [String]()
    

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
        
        ModelVehicle.shared.getModel { [weak self] model in
            self?.model = model
        }
        
        let yearRange = (2013..<2022)
        yearRange.forEach({ years.append($0.description) })
        
        let horsePowerRange = (1..<9)
        horsePowerRange.forEach { i in
            let sum = (10*i) + 70
            horsePower.append("\(sum) HP")
        }
    }
    
    @IBAction func brandButtonHandler(_ sender: UIButton) {
        guard let brands = self.brands else { return }
        let brandMenu = RSSelectionMenu(dataSource: brands ) { (cell, item, indexPath) in
            cell.textLabel?.text = item.title ?? "NA"
        }
        brandMenu.setSelectedItems(items: [BrandModel()]) { [weak self] (item, index, isSelected, selectedItems) in
            self?.lblBrand.text = selectedItems.first?.title ?? ""
        }
        
        brandMenu.show(style: .alert(title: "Select Brands", action: "Done", height: Double(view.frame.height) / 3), from: self)
    }
    
    @IBAction func cityButtonHandler(_ sender: UIButton) {
        
        guard let cities = self.cities else { return }
        let citiesMenu = RSSelectionMenu(dataSource: cities) { (cell, item, indexPath) in
            cell.textLabel?.text = item.name ?? "NA"
        }
        
        citiesMenu.setSelectedItems(items: [CityModel()]) { [weak self] (item, index, isSelected, selectedItems) in
            self?.lblCity.text = selectedItems.first?.name ?? ""
        }
        
        citiesMenu.show(style: .alert(title: "Select Cities", action: "Done", height: Double(view.frame.height) / 3), from: self)
    }
    
    @IBAction func modelButtonHandler(_ sender: UIButton) {
        guard let model = self.model else { return }
        let modelMenu = RSSelectionMenu(dataSource: model ) { (cell, item, indexPath) in
            cell.textLabel?.text = item.name ?? "NA"
        }
        modelMenu.setSelectedItems(items: [VehicleModel()]) { [weak self] (item, index, isSelected, selectedItems) in
            self?.lblModel.text = selectedItems.first?.name ?? ""
        }
        
        modelMenu.show(style: .alert(title: "Select Modelvech", action: "Done", height: Double(view.frame.height) / 3), from: self)
    }
    
    @IBAction func yearButtonHandler(_ sender: UIButton) {
        let yearMenu = RSSelectionMenu(dataSource: years) { (cell, item, indexPath) in
            cell.textLabel?.text = item
        }
        
        yearMenu.setSelectedItems(items: [""]) { [weak self] (item, index, isSelected, selectedItems) in
            self?.lblYear.text = selectedItems.first
        }
        
        yearMenu.show(style: .alert(title: "Select Years", action: "Done", height: Double(view.frame.height) / 3), from: self)
    }
    
    @IBAction func HorsePowerButtonHandler(_ sender: UIButton) {
        
        let hpMenu = RSSelectionMenu(selectionStyle: .single ,dataSource: horsePower) { (cell, item, indexPath) in
            cell.textLabel?.text = item
            cell.accessoryType = .none
            cell.isSelected = false
            cell.selectionStyle = .none
        }
        
        hpMenu.setSelectedItems(items: [""], maxSelected: 1) { [weak self] (item, index, isSelected, selectedItems) in
            self?.lblHP.text = selectedItems.first
        }
        hpMenu.maxSelectionLimit = 1
        
        hpMenu.show(style: .alert(title: "Select Horse Power", action: "Done", height: Double(view.frame.height) / 3), from: self)
    }

}
