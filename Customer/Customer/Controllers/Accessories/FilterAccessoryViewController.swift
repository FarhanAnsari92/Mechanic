//
//  FilterAccessoryViewController.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 10/10/2021.
//

import UIKit

class FilterAccessoryViewController: HomeBaseViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(FilterSortTableViewCell.nib, forCellReuseIdentifier: FilterSortTableViewCell.identifier)
            
            tableView.register(FilterPriceTableViewCell.nib, forCellReuseIdentifier: FilterPriceTableViewCell.identifier)
                        
            tableView.register(FilterWarrantyTypeTableViewCell.nib, forCellReuseIdentifier: FilterWarrantyTypeTableViewCell.identifier)
            
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Filter"
        setupBackButton(color: .white)
    }
    
}

extension FilterAccessoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let vu = BookingDetailsHeader.loadNib
        if section == 0 || section ==  1 {
            vu.isClickable = false
        } else {
            vu.isClickable = true
            vu.completion = {
                print("header click")
            }
        }
        
        switch section {
        case 0:
            vu.lblHeaderTitle.text = "Sort"
            
        case 1:
            vu.lblHeaderTitle.text = "Price"
            
        case 2:
            vu.lblHeaderTitle.text = "Warranty Type"
            vu.isExpand = true
            
        case 3:
            vu.lblHeaderTitle.text = "Services"
            vu.isExpand = false
            
        default:
            vu.lblHeaderTitle.text = "Model Year"
            vu.isExpand = false
        }
        return vu
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        } else if section == 3 || section == 4 {
            return 0
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
        let cell = tableView.dequeueReusableCell(withIdentifier: FilterSortTableViewCell.identifier, for: indexPath) as! FilterSortTableViewCell
        cell.isSelected = indexPath.row == 0
        return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: FilterPriceTableViewCell.identifier, for: indexPath) as! FilterPriceTableViewCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: FilterWarrantyTypeTableViewCell.identifier, for: indexPath) as! FilterWarrantyTypeTableViewCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 2 {
            return 80
        }
        return 45
    }
    
    
}
