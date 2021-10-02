//
//  BookingHistoryViewController.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 02/10/2021.
//

import UIKit

class BookingHistoryViewController: HomeBaseViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(BookingHistoryTableViewCell.nib, forCellReuseIdentifier: BookingHistoryTableViewCell.identifier)
            tableView.delegate = self
            tableView.dataSource = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "History"
        setupBackButton(color: .white)
    }
    
}

extension BookingHistoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let vu = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 35))
        vu.backgroundColor = .white
        let lbl = UILabel(frame: CGRect(x: 20, y: 10, width: self.view.frame.width, height: 35))
        lbl.text = "Past Bookings"
        lbl.font = UIFont.Poppins(.semiBold, size: 18)
        vu.addSubview(lbl)
        return vu
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BookingHistoryTableViewCell.identifier, for: indexPath) as! BookingHistoryTableViewCell
        cell.viewDetailsCompletion = { [weak self] in
            guard let self = self else { return }
            let sb = UIStoryboard(storyboard: .tracking)
            let vc = sb.instantiateViewController(withIdentifier: BookingDetailsViewController.storyboardIdentifier)
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return BookingHistoryTableViewCell.height
    }
    
}
