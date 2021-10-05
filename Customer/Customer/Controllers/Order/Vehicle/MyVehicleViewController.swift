//
//  MyVehicleViewController.swift
//  Customer
//
//  Created by Mohammad Farhan on 10/2/21.
//

import UIKit

class MyVehicleViewController: UIViewController {

    @IBOutlet weak var tblview_vic: UITableView!{
        didSet{
            tblview_vic.dataSource = self
            tblview_vic.delegate = self
            tblview_vic.register(MyVehicleTableViewCell.nib, forCellReuseIdentifier: MyVehicleTableViewCell.identifier)
        }
    }
    
    @IBOutlet weak var btnAddNew: UIButton! {
        didSet {
            btnAddNew.layer.cornerRadius = 10
            btnAddNew.backgroundColor = UIColor.Theme.green
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "My Vehicle"

        
    }
    
    @IBAction func AddNewButtonHandler(_ sender: UIButton) {
           let sb = UIStoryboard(storyboard: .order)
           let vc = sb.instantiateViewController(withIdentifier: HistoryViewController.storyboardIdentifier)
           self.navigationController?.pushViewController(vc, animated: true)
       }
 
}

extension MyVehicleViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MyVehicleTableViewCell.identifier, for: indexPath)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    
}

