//
//  SelectServicesViewControllerViewController.swift
//  Customer
//
//  Created by Mohammad Farhan on 10/8/21.
//

import UIKit

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
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Select Services"
        setupBackButton(color: .white)

        
    }
    
    
    @IBAction func btn_proceed(_ sender: UIButton) {
        
        let sb = UIStoryboard(storyboard: .vehicle)
        let vc = sb.instantiateViewController(withIdentifier: SelectModeViewController.storyboardIdentifier)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension SelectServicesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SelectServicesTableViewCell.identifier, for: indexPath) as! SelectServicesTableViewCell
        if indexPath.row == 1 {
            cell.isSelected = false
            cell.lblDesc.text = "Long Text Long Text Long Text Long Text Long Text Long Text Long Text Long Text Long Text Long Text Long Text Long Text"
        } else {
            cell.isSelected = true
        }
        return cell
    
    }
    
    
}
