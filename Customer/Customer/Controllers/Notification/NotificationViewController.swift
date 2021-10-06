//
//  NotificationViewController.swift
//  Customer
//
//  Created by Mohammad Farhan on 10/5/21.
//

import UIKit

class NotificationViewController: HomeBaseViewController {

    @IBOutlet weak var tableView: UITableView! {
           didSet {
               tableView.delegate = self
               tableView.dataSource = self
               tableView.register(NotificationTableViewCell.nib, forCellReuseIdentifier: NotificationTableViewCell.identifier)
           }
       }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackButton(color: .white)
        self.title = "Notification"
    }
    

}

extension NotificationViewController : UITableViewDataSource , UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NotificationTableViewCell.identifier, for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
