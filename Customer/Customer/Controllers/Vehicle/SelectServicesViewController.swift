//
//  SelectServicesViewControllerViewController.swift
//  Customer
//
//  Created by Mohammad Farhan on 10/8/21.
//

import UIKit
import ObjectMapper

class SelectServicesViewController: HomeBaseViewController {
    
    @IBOutlet weak var topLine: UIView!
    @IBOutlet weak var bottomLine: UIView!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var lblAmount: UILabel!

    @IBOutlet weak var tableview: UITableView!{
        didSet{
            tableview.delegate = self
            tableview.dataSource = self
            tableview.register(SelectServicesTableViewCell.nib, forCellReuseIdentifier: SelectServicesTableViewCell.identifier)
        }
    }
    
    var services: [Service]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Select Services"
        setupBackButton(color: .white)
        getServeices()
        self.lblAmount.text = getTotalAmount().description

        
    }
    
    func getServeices() {
        APIClient.callApi(api: .service, method: .get, view: self.view) { [weak self] data in
            if let dictionary = data, let serviceResponseModel = Mapper<ServiceResponseModel>().map(JSON: dictionary) {
                self?.services = serviceResponseModel.service?.services
                self?.tableview.reloadData()
            }
        }
    }
    
    
    @IBAction func btn_proceed(_ sender: UIButton) {
        
        let sb = UIStoryboard(storyboard: .vehicle)
        let vc = sb.instantiateViewController(withIdentifier: SelectModeViewController.storyboardIdentifier)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    //Get Total
    func getTotalAmount() -> Int {
        var total = 0
        self.services?.forEach({ service in
            if service.isSelected {
                total += service.charges ?? 0
            }
        })
        return total
    }
    
}

extension SelectServicesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.services?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SelectServicesTableViewCell.identifier, for: indexPath) as! SelectServicesTableViewCell
        let item = self.services?[indexPath.row]
        cell.lblTitle.text = item?.name ?? "NA"
        cell.lblDesc.text = item?.description ?? "NA"
        cell.lblAmount.text = "Rs. \(item?.charges ?? 0)"
        cell.isSelected = item?.isSelected ?? false
        return cell
    
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let item = self.services?[indexPath.row]
        item?.isSelected = !(item?.isSelected ?? false)

        self.lblAmount.text = getTotalAmount().description
        tableView.reloadData()
    }
    
}
