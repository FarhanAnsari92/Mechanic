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
    
    var products: [ProductModel]?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Basket"
        setupBackButton(color: .white)
        getProducts()
    }
    
    func getProducts() {
        self.products = ProductCart.shared.getProducts()
        self.tableView.reloadData()
    }
    
    @IBAction func buyNowButtonHandler(_ sender: UIButton) {
        
        let sb = UIStoryboard(storyboard: .accessories)
        let vc = sb.instantiateViewController(withIdentifier: BuyAccessoriesConfirmationViewController.storyboardIdentifier)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension BasketListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {  return 1 }
        return self.products?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: BasketTableViewCell.identifier, for: indexPath) as! BasketTableViewCell
            if let prod = self.products?[indexPath.row] {
                cell.set(data: prod)
                cell.stepperComplition = { [weak self] (isIncremented, value) in
                    ProductCart.shared.set(quantity: value, to: prod)
                    self?.tableView.reloadSections(IndexSet(integer: 1), with: .fade)
                }
            }
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: BookingDetailsTableViewCell.identifier, for: indexPath) as! BookingDetailsTableViewCell
        cell.topLine.isHidden = true
        cell.bottomLine.isHidden = false
        cell.lblLeft.text = "Total"
        cell.lblLeft.font = UIFont.Poppins(.light, size: 16)
        let formattedTotal = Helper.formatCurrency(value: ProductCart.shared.getTotal()) ?? "0"
        cell.lblRight.text = "Rs. \(formattedTotal)"
        cell.lblRight.font = UIFont.Poppins(.bold, size: 16)
        cell.lblRight.textColor = UIColor.Theme.green
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 {
            return 45
        }
        return 130
    }
    
    
    
}
