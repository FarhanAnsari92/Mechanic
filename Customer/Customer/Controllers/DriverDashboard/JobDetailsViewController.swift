//
//  JobDetailsViewController.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 02/12/2021.
//

import UIKit

class JobDetailsViewController: UIViewController {
    
    @IBOutlet weak var tableview: UITableView! {
        didSet {
            tableview.delegate = self
            tableview.dataSource = self
            tableview.register(ConfirmBookingTableViewCell.nib, forCellReuseIdentifier: ConfirmBookingTableViewCell.identifier)
            tableview.register(BuyAccessoriesConfirmationPaymentMethodTableViewCell.nib, forCellReuseIdentifier: BuyAccessoriesConfirmationPaymentMethodTableViewCell.identifier)
        }
    }
    
    var data: [Section] = [Section]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

extension JobDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = data[indexPath.row]
//        if item.title == "Payment Method" {
//            let cell = tableView.dequeueReusableCell(withIdentifier: BuyAccessoriesConfirmationPaymentMethodTableViewCell.identifier, for: indexPath)
//            return cell
//        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ConfirmBookingTableViewCell.identifier, for: indexPath) as! ConfirmBookingTableViewCell
        cell.setData(section: item)
        cell.changeCompletion = { [weak self] in
            if indexPath.row == 0 {
                if let myVehicle = self?.navigationController?.viewControllers.first(where: { $0 is MyVehicleViewController }) {
                    self?.navigationController?.popToViewController(myVehicle, animated: true)
                }
            } else if indexPath.row == 1 {
                if let selectService = self?.navigationController?.viewControllers.first(where: { $0 is SelectServicesViewController }) {
                    self?.navigationController?.popToViewController(selectService, animated: true)
                }
            } else if indexPath.row == 2 {
                if let selectMode = self?.navigationController?.viewControllers.first(where: { $0 is SelectModeViewController }) {
                    self?.navigationController?.popToViewController(selectMode, animated: true)
                }
            }
        }
        return cell
    }
    
}
