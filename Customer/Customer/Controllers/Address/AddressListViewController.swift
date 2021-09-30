//
//  AddressListViewController.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 29/09/2021.
//

import UIKit

class AddressListViewController: HomeBaseViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(AddressListTableViewCell.nib, forCellReuseIdentifier: AddressListTableViewCell.identifier)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Address"
        self.setupBackButton(color: .white)
    }

}

extension AddressListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AddressListTableViewCell.identifier, for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return AddressListTableViewCell.height
    }
    
    
}
