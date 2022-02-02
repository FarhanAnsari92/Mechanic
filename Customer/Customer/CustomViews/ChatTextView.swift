//
//  ChatTextView.swift
//  Customer
//
//  Created by Mohammad Farhan on 2/2/22.
//

import UIKit

class ChatTextView: UIView {
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var textViewHeight: NSLayoutConstraint!
    
    var placeholderLabel : UILabel!

    static var loadNib: ChatTextView {
        return Bundle.main.loadNibNamed("ChatTextView", owner: self, options: nil)?.first as! ChatTextView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        textView.delegate = self
        textView.backgroundColor = UIColor.fill(white: 241)
        textView.layer.cornerRadius = 7
        
        placeholderLabel = UILabel()
        placeholderLabel.text = "Type Message"
        
        placeholderLabel.font = UIFont.systemFont(ofSize: (textView.font?.pointSize)!)
        placeholderLabel.sizeToFit()
        textView.addSubview(placeholderLabel)
        placeholderLabel.frame.origin = CGPoint(x: 5, y: (textView.font?.pointSize)! / 2)
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.isHidden = !textView.text.isEmpty
        
    }
    
    override var intrinsicContentSize: CGSize {
        return textViewContentSize()
    }
    
    func textViewContentSize() -> CGSize {
        let size = CGSize(width: textView.bounds.width,
                          height: CGFloat.greatestFiniteMagnitude)
     
        let textSize = textView.sizeThatFits(size)
        return CGSize(width: bounds.width, height: textSize.height)
    }
    
}

extension ChatTextView: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
        let contentHeight = textViewContentSize().height
        guard contentHeight < 150 else { return }
        if textViewHeight.constant != contentHeight {
            textViewHeight.constant = textViewContentSize().height
            layoutIfNeeded()
        }
    }
    
}
