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
    
    var threadId: String?
    
    var messages: [MessageModel]?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Chat"
        setupBackButton(color: .white)
        setupTextView()
//        scrollToBottom()
        if let tId = self.threadId {
            SocketIOManager.shared.emit(.joinRoom, parameters: ["thread_id": tId])
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        becomeFirstResponder()
        addObserver()
        SocketIOManager.shared.on(.getThreads) { (data, ack) in
            print("thread --- ", data)
        }
        
        SocketIOManager.shared.on(.threadJoined) { [weak self] (data, ack) in
            guard let self = self else { return }
            if let dictArray = data as? [[String:Any]],
                let firstDict = dictArray.first {
                let obj = ObjectMapperManager<ChatModel>().map(dictionary: firstDict)
                let messages = obj?.messages
                self.messages = messages
                self.tableView.reloadData()
                self.scrollToBottom()
            }
        }
        
        SocketIOManager.shared.on(.newMessage) { (data, ack) in
            print("MESSAGE --- ", data)
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.textView.resignFirstResponder()
        removeObserver()
        SocketIOManager.shared.off(.getThreads)
        SocketIOManager.shared.off(.threadJoined)
        SocketIOManager.shared.off(.newMessage)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("super.viewDidLayoutSubviews()")
    }
    
    override var inputAccessoryView: UIView? {
        get {
            let vu = ChatTextView.loadNib
            return vu
        }
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override var canResignFirstResponder: Bool {
        return true
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
        guard let count = self.messages?.count else {
            return
        }
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: count - 1, section: 0)
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
        
        guard let message = self.textView.text else {
            fatalError("Unable to get message.")
        }
        guard let tId = self.threadId else {
            fatalError("Unable to find thread id")
        }
        var data = [String:Any]()
        data["message"] = message // "message 3 from rider."
        data["thread_id"] = tId
        SocketIOManager.shared.emit(.sendMessage, parameters: data)
    }
    
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messages?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let message = self.messages?[indexPath.row] else {
            fatalError("Unable to get message.")
        }
        if message.isMe {
            let cell = tableView.dequeueReusableCell(withIdentifier: ChatSenderTableViewCell.identifier, for: indexPath) as! ChatSenderTableViewCell
            cell.lblMessage.text = message.message
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: ChatReceiverTableViewCell.identifier, for: indexPath) as! ChatReceiverTableViewCell
            cell.lblMessage.text = message.message
            return cell
        }
    }
    
}
