//
//  OrderListViewController.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 26/09/2021.
//

import UIKit

class OrderHistoryViewController: HomeBaseViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(OrderHistoryTableViewCell.nib, forCellReuseIdentifier: OrderHistoryTableViewCell.identifier)
        }
    }
    
    var orders: [OrderModel]?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Order History"
        self.setupBackButton(color: .white)
        getOrders()
    }
    
    func getOrders() {
        APIClient.callApi(api: .orders,  method: .get, view: self.view) { (data) in
            if let dictionary = data {
                let obj = ObjectMapperManager<OrderResponseModel>().map(dictionary: dictionary);
                let orders = obj?.data?.orders
                self.orders = orders
                self.tableView.reloadData()
            }
        }
    }

}

extension OrderHistoryViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.orders?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let orderInfoView = OrderInfoView.loadNib
        if let order = self.orders?[section] {
            orderInfoView.tapCompletion = {
                order.shouldExpand.toggle()
                tableView.reloadSections(IndexSet(integer: section), with: .fade)
            }
            orderInfoView.set(data: order)
        }
        return orderInfoView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let order = self.orders?[section] {
            return order.shouldExpand ? (order.products?.count ?? 0) : 0
        }
        return 0
        //return self.orders?[section].products?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OrderHistoryTableViewCell.identifier, for: indexPath) as! OrderHistoryTableViewCell
        if let order = self.orders?[indexPath.section],
           let product = order.products?[indexPath.row] {
            cell.set(product: product)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 110
    }
    
    
}
