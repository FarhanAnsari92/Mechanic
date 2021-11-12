//
//  BuyAccessoriesConfirmationViewController.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 08/10/2021.
//

import UIKit

class BuyAccessoriesConfirmationViewController: HomeBaseViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(BuyAccessoriesConfirmationAddressTableViewCell.nib, forCellReuseIdentifier: BuyAccessoriesConfirmationAddressTableViewCell.identifier)
            
            tableView.register(BuyAccessoriesConfirmationBasketTableViewCell.nib, forCellReuseIdentifier: BuyAccessoriesConfirmationBasketTableViewCell.identifier)
                        
            tableView.register(BuyAccessoriesConfirmationPaymentMethodTableViewCell.nib, forCellReuseIdentifier: BuyAccessoriesConfirmationPaymentMethodTableViewCell.identifier)
            
            tableView.delegate = self
            tableView.dataSource = self
            
        }
    }
    
    var product: ProductModel?
    var selectedAddress: AddressModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Terms & Conditions"
        setupBackButton(color: .white)
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        
        getAddress()
        
    }
    
    func getAddress() {
        APIClient.callApi(api: .address, method: .get, view: self.view) { [weak self] data in
            if let dictionary = data, let addressResponseModel = ObjectMapperManager<AddressResponseModel>().map(dictionary: dictionary) {
                if addressResponseModel.success ?? false {
                    let addresses = addressResponseModel.addressesModel?.addresses
                    let address = addresses?.first
                    self?.selectedAddress = address
                    self?.tableView.reloadSections(IndexSet(integer: 0), with: .fade)
                }
            }
        }
    }
    
    @IBAction func confirmButtonHandler(_ sender: UIButton) {
        let sb = UIStoryboard(storyboard: .accessories)
        let vc = sb.instantiateViewController(withIdentifier: BuyAccessoriesSuccessfullViewController.storyboardIdentifier)
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

extension BuyAccessoriesConfirmationViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: BuyAccessoriesConfirmationAddressTableViewCell.identifier, for: indexPath) as! BuyAccessoriesConfirmationAddressTableViewCell
            if let address = self.selectedAddress {
                cell.set(data: address)
            }
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: BuyAccessoriesConfirmationBasketTableViewCell.identifier, for: indexPath) as! BuyAccessoriesConfirmationBasketTableViewCell
            if let prod = self.product {
                cell.set(data: prod)
            }
            return cell
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: BuyAccessoriesConfirmationPaymentMethodTableViewCell.identifier, for: indexPath)
            
            return cell
        }
        
    }
}
