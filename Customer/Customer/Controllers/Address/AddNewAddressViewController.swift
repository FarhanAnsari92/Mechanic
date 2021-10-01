//
//  AddNewAddressViewController.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 01/10/2021.
//

import UIKit

class AddNewAddressViewController: HomeBaseViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(AddressListTableViewCell.nib, forCellReuseIdentifier: AddressListTableViewCell.identifier)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Select Location"
        self.setupBackButton(color: .white)
    }

}

extension AddNewAddressViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let vu = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width / 2, height: 20))
        vu.backgroundColor = .white
        let lbl = UILabel(frame: CGRect(x: 20, y: 10, width: self.view.frame.width / 2, height: 15))        
        lbl.text = "Search Result"
        lbl.font = UIFont.Poppins(.regular, size: 12)
        lbl.textColor = UIColor(hexString: "9CA3AF")
        vu.addSubview(lbl)
        return vu
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AddressListTableViewCell.identifier, for: indexPath) as! AddressListTableViewCell
        cell.imgEdit.isHidden = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return AddressListTableViewCell.height
    }
    
    
}

