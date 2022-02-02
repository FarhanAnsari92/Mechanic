//
//  ChatTextView.swift
//  Customer
//
//  Created by Mohammad Farhan on 2/2/22.
//

import UIKit

class ChatTextView: UIView {

    static var loadNib: ChatTextView {
        return Bundle.main.loadNibNamed("ChatTextView", owner: self, options: nil)?.first as! ChatTextView
    }
}
