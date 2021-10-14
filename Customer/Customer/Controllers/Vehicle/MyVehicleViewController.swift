//
//  MyVehicleViewController.swift
//  Customer
//
//  Created by Mohammad Farhan on 10/8/21.
//

import UIKit

class MyVehicleViewController: HomeBaseViewController {
    
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(MyVehicleTableViewCell.nib, forCellReuseIdentifier: MyVehicleTableViewCell.identifier)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "MY Vehicle"
        setupBackButton(color: .white)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        
    }
    
    @IBAction func addNewVehicleButtonHandler(_ sender: UIButton) {
        let sb = UIStoryboard(storyboard: .vehicle)
        let vc = sb.instantiateViewController(withIdentifier: AddNewVehicleViewController.storyboardIdentifier)
        self.navigationController?.pushViewController(vc, animated: true)
    }
 
}

extension MyVehicleViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MyVehicleTableViewCell.identifier, for: indexPath)
        
        return cell
    }
    
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//
//        return 110
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(storyboard: .vehicle)
        let vc = sb.instantiateViewController(withIdentifier: SelectServicesViewController.storyboardIdentifier)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
