//
//  AddNewVehicleViewController.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 13/10/2021.
//

import UIKit
import AVFoundation
import Photos
import RSSelectionMenu

class AddNewVehicleViewController: HomeBaseViewController {
    
    @IBOutlet weak var lblBrand: UILabel!
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblYear: UILabel!
    @IBOutlet weak var lblHP: UILabel!
    @IBOutlet weak var lblModel : UILabel!
    
    var brandId: String?
    var modelId: String?
    var cityId: String?
    var horsePower: String?
    var year: String?
    
    var cities: [CityModel]?
    var brands: [BrandModel]?
    var model : [VehicleModel]?
    var years: [String] = [String]()
    var horsePowers: [String] = [String]()
    
    var selectedImage: UIImage?
    

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
            horsePowers.append("\(sum) HP")
        }
    }
    
    @IBAction func brandButtonHandler(_ sender: UIButton) {
        guard let brands = self.brands else { return }
        let brandMenu = RSSelectionMenu(dataSource: brands ) { [weak self] (cell, item, indexPath) in
            self?.brandId = item.id?.description
            cell.textLabel?.text = item.title ?? "NA"
        }
        brandMenu.setSelectedItems(items: [BrandModel()]) { [weak self] (item, index, isSelected, selectedItems) in
            self?.brandId = selectedItems.first?.id?.description
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
            self?.cityId = selectedItems.first?.id?.description
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
            self?.modelId = selectedItems.first?.id?.description
            self?.lblModel.text = selectedItems.first?.name ?? ""
        }
        
        modelMenu.show(style: .alert(title: "Select Modelvech", action: "Done", height: Double(view.frame.height) / 3), from: self)
    }
    
    @IBAction func yearButtonHandler(_ sender: UIButton) {
        let yearMenu = RSSelectionMenu(dataSource: years) { (cell, item, indexPath) in
            cell.textLabel?.text = item
        }
        
        yearMenu.setSelectedItems(items: [""]) { [weak self] (item, index, isSelected, selectedItems) in
            self?.year = selectedItems.first
            self?.lblYear.text = selectedItems.first
        }
        
        yearMenu.show(style: .alert(title: "Select Years", action: "Done", height: Double(view.frame.height) / 3), from: self)
    }
    
    @IBAction func HorsePowerButtonHandler(_ sender: UIButton) {
        
        let hpMenu = RSSelectionMenu(selectionStyle: .single ,dataSource: horsePowers) { (cell, item, indexPath) in
            cell.textLabel?.text = item
            cell.accessoryType = .none
            cell.isSelected = false
            cell.selectionStyle = .none
        }
        
        hpMenu.setSelectedItems(items: [""], maxSelected: 1) { [weak self] (item, index, isSelected, selectedItems) in
            self?.horsePower = selectedItems.first
            self?.lblHP.text = selectedItems.first
        }
        hpMenu.maxSelectionLimit = 1
        
        hpMenu.show(style: .alert(title: "Select Horse Power", action: "Done", height: Double(view.frame.height) / 3), from: self)
    }
    
    @IBAction func openImagePickerButtonHandler(_ sender: UIButton) {
        openActionSheet()
    }
    
    @IBAction func saveVehicleButtonHandler(_ sender: UIButton) {
        callMultipartApi()
    }
    
    func callMultipartApi() {
        
        guard let brandId = self.brandId else {
            Helper.showMessage(text: "Please select brand.")
            return
        }
        
        guard let horsePower = self.horsePower else {
            Helper.showMessage(text: "Please select horse power.")
            return
        }
        
        guard let year = self.year else {
            Helper.showMessage(text: "Please select year.")
            return
        }
        
        guard let modelId = self.modelId else {
            Helper.showMessage(text: "Please select model.")
            return
        }
        
        guard let cityId = self.cityId else {
            Helper.showMessage(text: "Please select city.")
            return
        }
        
        guard let image = selectedImage else {
            Helper.showMessage(text: "Please select photo of vehicle paper.")
            return
        }

        var parameters: [String:String] = [String:String]()
        parameters["brand_id"] = brandId
        parameters["model_id"] = modelId
        parameters["city_id"] = cityId
        parameters["number_plate"] = "Khi628"
        parameters["horse_power"] = horsePower
        parameters["year"] = year
        
        APIClient.multipartRequest(api: .vehicle, parameters: parameters, image: image, method: .post, view: self.view) { data in
            print(data)
        }
    }

}

extension AddNewVehicleViewController: UIImagePickerControllerDelegate {
    
    func openActionSheet() {
        let alert = UIAlertController(title: "Select Image", message: "Select Image", preferredStyle: .actionSheet)
        
        let galleryAction = UIAlertAction(title: "Gallery", style: .default) { [weak self] action in
            alert.dismiss(animated: true, completion: nil)
            guard let self = self else { return }
            PermissionManager.shared.requestAccess(vc: self, .cameraUsage) { isAllowed in
                if isAllowed {
                    self.openImagePicker(sourceType: .photoLibrary)
                }
            }
        }
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { [weak self] action in
            alert.dismiss(animated: true, completion: nil)
            guard let self = self else { return }
            PermissionManager.shared.requestAccess(vc: self, .photoLibraryUsage) { isAllowed in
                if isAllowed {
                    self.openImagePicker(sourceType: .camera)
                }
            }
        }
        
        alert.addAction(galleryAction)
        alert.addAction(cameraAction)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in alert.dismiss(animated: true, completion: nil) }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func openImagePicker(sourceType: UIImagePickerController.SourceType) {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.allowsEditing = true
        picker.delegate = self
        picker.modalPresentationStyle = .fullScreen
        self.present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let originalImage = info[.originalImage] as? UIImage {
            self.selectedImage = originalImage
        } else if let editedImage = info[.editedImage] as? UIImage {
            self.selectedImage = editedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
}
