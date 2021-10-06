//
//  ChatViewController.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 07/10/2021.
//

import UIKit

class ChatViewController: HomeBaseViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(ChatSenderTableViewCell.nib, forCellReuseIdentifier: ChatSenderTableViewCell.identifier)
            tableView.register(ChatReceiverTableViewCell.nib, forCellReuseIdentifier: ChatReceiverTableViewCell.identifier)
            
            tableView.delegate = self
            tableView.dataSource = self
            tableView.estimatedRowHeight = 80
            tableView.rowHeight = UITableView.automaticDimension
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Chat"
        setupBackButton(color: .white)
        
    }
    
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row % 2 == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ChatSenderTableViewCell.identifier, for: indexPath) as! ChatSenderTableViewCell
            cell.lblMessage.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco"
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: ChatReceiverTableViewCell.identifier, for: indexPath) as! ChatReceiverTableViewCell
            cell.lblMessage.text = "Hello!"
            return cell
        }
//        if indexPath.row == 0 {
//            cell.lblMessage.text = "Hello!"
//        } else {
//            cell.lblMessage.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco"
//        }
        
//        return cell
    }
    
}
