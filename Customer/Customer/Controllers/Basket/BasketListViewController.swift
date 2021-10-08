//
//  BasketListViewController.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 09/10/2021.
//

import UIKit

class BasketListViewController: HomeBaseViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(BookingDetailsTableViewCell.nib, forCellReuseIdentifier: BookingDetailsTableViewCell.identifier)
            tableView.register(BasketTableViewCell.nib, forCellReuseIdentifier: BasketTableViewCell.identifier)
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Basket"
        setupBackButton(color: .white)
    }
    
    @IBAction func buyNowButtonHandler(_ sender: UIButton) {
        
        let sb = UIStoryboard(storyboard: .accessories)
        let vc = sb.instantiateViewController(withIdentifier: BuyAccessoriesConfirmationViewController.storyboardIdentifier)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension BasketListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.row == 4 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: BookingDetailsTableViewCell.identifier, for: indexPath) as! BookingDetailsTableViewCell
            cell.topLine.isHidden = true
            cell.bottomLine.isHidden = false
            cell.lblLeft.text = "Total"
            cell.lblLeft.font = UIFont.Poppins(.light, size: 16)
            cell.lblRight.text = "Rs. 2,300"
            cell.lblRight.font = UIFont.Poppins(.bold, size: 16)
            cell.lblRight.textColor = UIColor.Theme.green
            
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: BasketTableViewCell.identifier, for: indexPath) as! BasketTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 4 {
            return 45
        }
        return 130
    }
    
    
    
}
