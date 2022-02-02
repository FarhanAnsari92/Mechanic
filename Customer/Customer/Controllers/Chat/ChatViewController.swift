//
//  ChatViewController.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 07/10/2021.
//

import UIKit
import GrowingTextView

// https://objectpartners.com/2019/07/09/building-an-ios-chat-feature-without-hacks/

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
    
    var chatView: ChatTextView?
    
    var shouldScrollToBottom = true
//    var shouldAdjustForKeyboard = true // use it when interactive pop gesture is on
    
    var threadId: String?
    
    var messages: [MessageModel]?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Chat"
        setupBackButton(color: .white)
        chatView = ChatTextView.loadNib
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
        removeObserver()
        SocketIOManager.shared.off(.getThreads)
        SocketIOManager.shared.off(.threadJoined)
        SocketIOManager.shared.off(.newMessage)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if shouldScrollToBottom {
            shouldScrollToBottom = false
            scrollToBottom(animated: false)
        }
    }
    
    func scrollToBottom(animated: Bool) {
        view.layoutIfNeeded()
        tableView.setContentOffset(bottomOffset(), animated: animated)
    }
     
    func bottomOffset() -> CGPoint {
        return CGPoint(x: 0, y: max(-tableView.contentInset.top, tableView.contentSize.height - (tableView.bounds.size.height - tableView.contentInset.bottom)))
    }
    
    override var inputAccessoryView: UIView? {
        get {
            if let vu = chatView {
                vu.sendMessageCompletion = { [weak self] message in
                    self?.send(message)
                }
                return vu
            }
            return ChatTextView.loadNib
        }
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override var canResignFirstResponder: Bool {
        return true
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
        adjustContentForKeyboard(shown: true, notification: notification)
        
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        adjustContentForKeyboard(shown: false, notification: notification)
        
    }
    
    func adjustContentForKeyboard(shown: Bool, notification: Notification) {
        guard let payload = KeyboardInfo(notification) else { return }
     
        let keyboardHeight = shown ? payload.frameEnd.size.height : chatView?.bounds.size.height ?? 0
        if tableView.contentInset.bottom == keyboardHeight {
            return
        }
     
        let distanceFromBottom = bottomOffset().y - tableView.contentOffset.y
     
        var insets = tableView.contentInset
        insets.bottom = keyboardHeight
     
        UIView.animate(withDuration: payload.animationDuration, delay: 0, options: .overrideInheritedOptions, animations: {
     
            self.tableView.contentInset = insets
            self.tableView.scrollIndicatorInsets = insets
     
            if distanceFromBottom < 10 {
                self.tableView.contentOffset = self.bottomOffset()
            }
        }, completion: nil)
    }
    
    func send(_ message: String) {
        
        guard let tId = self.threadId else {
            fatalError("Unable to find thread id")
        }
        var data = [String:Any]()
        data["message"] = message
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


struct KeyboardInfo {
    var animationCurve: UIView.AnimationCurve
    var animationDuration: Double
    var isLocal: Bool
    var frameBegin: CGRect
    var frameEnd: CGRect
}

extension KeyboardInfo {
    init?(_ notification: Notification) {
        guard notification.name == UIResponder.keyboardWillShowNotification || notification.name == UIResponder.keyboardWillChangeFrameNotification else { return nil }
        let u = notification.userInfo!

        animationCurve = UIView.AnimationCurve(rawValue: u[UIWindow.keyboardAnimationCurveUserInfoKey] as! Int)!
        animationDuration = u[UIWindow.keyboardAnimationDurationUserInfoKey] as! Double
        isLocal = u[UIWindow.keyboardIsLocalUserInfoKey] as! Bool
        frameBegin = u[UIWindow.keyboardFrameBeginUserInfoKey] as! CGRect
        frameEnd = u[UIWindow.keyboardFrameEndUserInfoKey] as! CGRect
    }
}
