//
//  TrackingViewController.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 02/10/2021.
//

import UIKit

class TrackingViewController: HomeBaseViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(ImageTableViewCell.nib, forCellReuseIdentifier: ImageTableViewCell.identifier)
            tableView.register(TrackingBookingNumberTableViewCell.nib, forCellReuseIdentifier: TrackingBookingNumberTableViewCell.identifier)
            tableView.register(TrackingStatusTableViewCell.nib, forCellReuseIdentifier: TrackingStatusTableViewCell.identifier)
            tableView.delegate = self
            tableView.dataSource = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Tracking"
        setupBackButton(color: .white)
        
        tableView.estimatedRowHeight = 50
    }

}

extension TrackingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let vu = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width / 2, height: 35))
        vu.backgroundColor = .white
        let lbl = UILabel(frame: CGRect(x: 20, y: 0, width: self.view.frame.width / 2, height: 35))
        lbl.text = "Service Status"
        lbl.font = UIFont.Poppins(.semiBold, size: 18)
        vu.addSubview(lbl)
        return vu
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 { return 0 }
        return 35
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 { return 2 }
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: ImageTableViewCell.identifier, for: indexPath)
                return cell
                
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: TrackingBookingNumberTableViewCell.identifier, for: indexPath)
                return cell
                
            }
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: TrackingStatusTableViewCell.identifier, for: indexPath)
            return cell
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0:
                return 150
            default:
                return UITableView.automaticDimension
            }
        } else {
            return 70
        }
    }
    
}
// 56
