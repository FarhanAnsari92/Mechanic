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
//            tableView.register(ConfirmBookingTableViewCell.nib, forCellReuseIdentifier: ConfirmBookingTableViewCell.identifier)
            tableView.register(BuyAccessoriesConfirmationAddressTableViewCell.nib, forCellReuseIdentifier: BuyAccessoriesConfirmationAddressTableViewCell.identifier)
            
            tableView.register(BuyAccessoriesConfirmationBasketTableViewCell.nib, forCellReuseIdentifier: BuyAccessoriesConfirmationBasketTableViewCell.identifier)
                        
            tableView.register(BuyAccessoriesConfirmationPaymentMethodTableViewCell.nib, forCellReuseIdentifier: BuyAccessoriesConfirmationPaymentMethodTableViewCell.identifier)
            
            tableView.delegate = self
            tableView.dataSource = self
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Terms & Conditions"
        setupBackButton(color: .white)
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        
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
            let cell = tableView.dequeueReusableCell(withIdentifier: BuyAccessoriesConfirmationAddressTableViewCell.identifier, for: indexPath)
            
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: BuyAccessoriesConfirmationBasketTableViewCell.identifier, for: indexPath)
            
            return cell
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: BuyAccessoriesConfirmationPaymentMethodTableViewCell.identifier, for: indexPath)
            
            return cell
        }
        
    }
}
