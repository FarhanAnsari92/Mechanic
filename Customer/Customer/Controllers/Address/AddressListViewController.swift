//
//  AddressListViewController.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 29/09/2021.
//

import UIKit

protocol AddressListViewControllerDelegate: NSObject {
    func didSelect(address: AddressModel)
}

class AddressListViewController: HomeBaseViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(AddressListTableViewCell.nib, forCellReuseIdentifier: AddressListTableViewCell.identifier)
        }
    }
    var addresses: [AddressModel]?
    
    weak var delegate: AddressListViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Address"
        self.setupBackButton(color: .white)
        getAddress()
    }
    
    @IBAction func addNewAddressButtonHandler(_ sender: UIButton) {
        let sb = UIStoryboard(storyboard: .address)
        let vc = sb.instantiateViewController(withIdentifier: AddNewAddressViewController.storyboardIdentifier)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func getAddress(){
        APIClient.callApi(api: .address, method: .get, view: self.view) { [weak self] data in
            if let dictionary = data, let addressResponseModel = ObjectMapperManager<AddressResponseModel>().map(dictionary: dictionary) {
                if addressResponseModel.success ?? false {
                    self?.addresses = addressResponseModel.addressesModel?.addresses
                    self?.tableView.reloadData()
                }
            }
        }
    }

}

extension AddressListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addresses?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AddressListTableViewCell.identifier, for: indexPath) as! AddressListTableViewCell
        if let address = self.addresses?[indexPath.row] {
            cell.set(data: address)
        }
        cell.imgPin.isHidden = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return AddressListTableViewCell.height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let sb = UIStoryboard(storyboard: .address)
//        let vc = sb.instantiateViewController(withIdentifier: AddNewAddressDetailsViewController.storyboardIdentifier)
//        self.navigationController?.pushViewController(vc, animated: true)
        if let address = self.addresses?[indexPath.row] {
            self.delegate?.didSelect(address: address)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
}
