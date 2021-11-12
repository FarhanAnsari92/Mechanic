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
    
    var products: [ProductModel]?
    var selectedAddress: AddressModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Terms & Conditions"
        setupBackButton(color: .white)
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        
        getAddress()
        self.products = ProductCart.shared.getProducts()
        self.tableView.reloadSections(IndexSet(integer: 1), with: .fade)
        
        
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
//        let sb = UIStoryboard(storyboard: .accessories)
//        let vc = sb.instantiateViewController(withIdentifier: BuyAccessoriesSuccessfullViewController.storyboardIdentifier)
//        self.navigationController?.pushViewController(vc, animated: true)
        
        createOrderRequest()
        
    }
    
    func createOrderRequest() {
        
        var parameters = [String:String]()
        parameters["address_id"] = self.selectedAddress?.id?.description
        parameters["delivery_charges"] = "300"
        parameters["payment_type"] = "creditcard"
//        parameters["coupon_code"] = "0" // optional
        
        for i in 0..<(ProductCart.shared.getProducts()?.count ?? 0) {
            if let product = ProductCart.shared.getProducts()?[i],
               let id = product.id {
                let qty = product.quantity
                parameters["products[\(i)][id]"] = id.description
                parameters["products[\(i)][qty]"] = qty.description
            }
        }
        
        print(parameters)
        
        APIClient.callApi(api: .orders, parameters: parameters, method: .post, data: nil, view: self.view) { dictionary in
            print("res dictionary", dictionary)
        }

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
            if let prdcts = self.products {
                cell.set(data: prdcts)
            }
            return cell
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: BuyAccessoriesConfirmationPaymentMethodTableViewCell.identifier, for: indexPath)
            
            return cell
        }
        
    }
}
