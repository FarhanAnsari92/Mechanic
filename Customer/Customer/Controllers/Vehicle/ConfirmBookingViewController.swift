//
//  ConfirmBookingViewController.swift
//  Customer
//
//  Created by Mohammad Farhan on 10/10/21.
//

import UIKit

class ConfirmBookingViewController: HomeBaseViewController {
    
    @IBOutlet weak var tableview: UITableView! {
        didSet {
            tableview.delegate = self
            tableview.dataSource = self
            tableview.register(ConfirmBookingTableViewCell.nib, forCellReuseIdentifier: ConfirmBookingTableViewCell.identifier)
            tableview.register(BuyAccessoriesConfirmationPaymentMethodTableViewCell.nib, forCellReuseIdentifier: BuyAccessoriesConfirmationPaymentMethodTableViewCell.identifier)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Confirm Booking"
        setupBackButton(color: .white)
    }
    
}

extension ConfirmBookingViewController : UITableViewDataSource , UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath.row == 3) {
            let cell = tableView.dequeueReusableCell(withIdentifier: BuyAccessoriesConfirmationPaymentMethodTableViewCell.identifier, for: indexPath)
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ConfirmBookingTableViewCell.identifier, for: indexPath)
        return cell
    }
    
}
