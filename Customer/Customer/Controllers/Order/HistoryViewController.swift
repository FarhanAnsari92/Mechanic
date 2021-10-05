//
//  HistoryViewController.swift
//  Customer
//
//  Created by Mohammad Farhan on 10/2/21.
//

import UIKit

class HistoryViewController: UIViewController {
    
    @IBOutlet weak var tblview: UITableView!{
        didSet{
            tblview.delegate = self
            tblview.dataSource = self
            tblview.register(HistoryTableViewCell.nib, forCellReuseIdentifier: HistoryTableViewCell.identifier)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "History"

        
    }
    

    

}

extension HistoryViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: HistoryTableViewCell.identifier, for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
