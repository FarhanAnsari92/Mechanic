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
    
    var statusHistory: [StatusHistoryModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Tracking"
        setupBackButton(color: .white)
//        setupHistoryButton()
        tableView.estimatedRowHeight = 50
    }
    
    func setupHistoryButton() {
        let btnHistory = UIBarButtonItem(title: "History", style: .plain, target: self, action: #selector(self.historyButtonHandler))
        
        btnHistory.setTitleTextAttributes(
            [.font: UIFont.Poppins(.medium, size: 14)],
            for: .normal
        )
        
        btnHistory.tintColor = .white
        navigationItem.rightBarButtonItem = btnHistory
    }
    
    @objc func historyButtonHandler() {
        let sb = UIStoryboard(storyboard: .tracking)
        let vc = sb.instantiateViewController(withIdentifier: BookingHistoryViewController.storyboardIdentifier)
        self.navigationController?.pushViewController(vc, animated: true)
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
        return self.statusHistory?.count ?? 0
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
            let cell = tableView.dequeueReusableCell(withIdentifier: TrackingStatusTableViewCell.identifier, for: indexPath) as! TrackingStatusTableViewCell
            cell.lblStatus.textColor = indexPath.row == 0 ? cell.selectedColor : cell.deselectedColor
            cell.imgTick.isHidden = indexPath.row > 0
            cell.deselectView.isHidden = indexPath.row == 0
            cell.upperLine.isHidden = indexPath.row == 0
            if let status = statusHistory {
                cell.lowerLine.isHidden = indexPath.row == status.count - 1
                cell.lblStatus.text = status[indexPath.row].title
            }
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
