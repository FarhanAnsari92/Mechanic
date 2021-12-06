//
//  DashBoardPickupViewController.swift
//  Customer
//
//  Created by Mohammad Farhan on 12/2/21.
//

import UIKit

class DashBoardPickupViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(DashboardJobTableViewCell.nib, forCellReuseIdentifier: DashboardJobTableViewCell.identifier)
            tableView.rowHeight = UITableView.automaticDimension
            tableView.estimatedRowHeight = 50
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    var jobs: [BookingHistoryModel]?

    override func viewDidLoad() {
        super.viewDidLoad()        
        self.getJob()
    }
    

    func getJob() {
        APIClient.callApi(api: .job, method: .get, view: view) { [weak self] data in
            if let dictionary = data {
                if let obj = ObjectMapperManager<BookingHistoryResponseModel>().map(dictionary: dictionary),
                   obj.success ?? false {
                    if let bookings = obj.bookings {
                        print("--- ", bookings.first?.toJSON())
                        self?.jobs = bookings
                        self?.tableView.reloadData()
                    }
                }
            }
        }
    }

}

extension DashBoardPickupViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobs?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DashboardJobTableViewCell.identifier, for: indexPath) as! DashboardJobTableViewCell
        if let data = self.jobs?[indexPath.row] {
            cell.set(data: data)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let sb = UIStoryboard(storyboard: .dashboard)
        let vc = sb.instantiateViewController(withIdentifier: JobDetailsViewController.storyboardIdentifier) as! JobDetailsViewController
        vc.jobDetails = self.jobs?[indexPath.row]
        self.parent?.navigationController?.pushViewController(vc, animated: true)
    }
    
}
