//
//  BookingDetailsViewController.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 02/10/2021.
//

import UIKit

class BookingDetailsViewController: HomeBaseViewController {
    
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(BookingDetailsTableViewCell.nib, forCellReuseIdentifier: BookingDetailsTableViewCell.identifier)
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Booking ID: 353SE2"
        setupBackButton(color: .white)
    }

}

extension BookingDetailsViewController : UITableViewDataSource , UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let vu = BookingDetailsHeader.loadNib
        if section == 0 {
            vu.lblHeaderTitle.text = "Service Details"
        } else if section == 1 {
            vu.lblHeaderTitle.text = "Service Mode"
        } else {
            vu.lblHeaderTitle.text = "Services"
        }
        
        return vu
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 || section == 2 {
            return 4
        }
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: BookingDetailsTableViewCell.identifier, for: indexPath) as! BookingDetailsTableViewCell
        if indexPath.section == 2, indexPath.row == 3 {
            cell.topLine.isHidden = false
            cell.bottomLine.isHidden = false
            cell.lblLeft.font = UIFont.Poppins(.light, size: 16)
            cell.lblRight.font = UIFont.Poppins(.bold, size: 16)
            cell.lblRight.textColor = UIColor.Theme.green
        } else {
            if indexPath.section == 1, indexPath.row == 1 {
                cell.lblRight.text = "Kaneez Fatima Society, Scheme 33, Karachi"
            }
            cell.topLine.isHidden = true
            cell.bottomLine.isHidden = true
            cell.lblLeft.font = UIFont.Poppins(.light, size: 12)
            cell.lblRight.font = UIFont.Poppins(.medium, size: 12)
            cell.lblRight.textColor = UIColor(hexString: "252525")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 2, indexPath.row == 3 {
            return 40
        }
        return UITableView.automaticDimension
    }
    
    
    
}
