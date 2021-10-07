//
//  ChatViewController.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 07/10/2021.
//

import UIKit
import GrowingTextView

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
    
    @IBOutlet weak var textView: GrowingTextView!
    @IBOutlet weak var containerViewBottomConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Chat"
        setupBackButton(color: .white)
        setupTextView()
        scrollToBottom()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addObserver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.textView.resignFirstResponder()
        removeObserver()
    }
    
    func setupTextView() {
        textView.maxLength = 140
        textView.trimWhiteSpaceWhenEndEditing = false
        textView.placeholderColor = UIColor(white: 0.8, alpha: 1.0)
        textView.minHeight = 25.0
        textView.maxHeight = 70.0
        textView.backgroundColor = UIColor(hexString: "F1F1F1")
        textView.layer.cornerRadius = textView.frame.height / 2
    }
    
    func scrollToBottom() {
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: 9, section: 0)
            self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    
    func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    func removeObserver() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }


    @objc func keyboardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            var safeArea: CGFloat = 0
            if #available(iOS 11.0, *) {
                let window = UIApplication.shared.keyWindow
                let bottomPadding = window?.safeAreaInsets.bottom
                safeArea = bottomPadding ?? 0
            }
            let bottomSpace = keyboardSize.height - safeArea
            containerViewBottomConstraint.constant = bottomSpace
            UIView.animate(withDuration: 0.25) {
                self.view.layoutIfNeeded()
            }
            
        }
        
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        containerViewBottomConstraint.constant = 0
        
        UIView.animate(withDuration: 0.25) {
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func sendMessageButtonHandler(_ sender: UIButton) {
        print("message to send - ", self.textView.text ?? "")
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
    }
    
}
