//
//  InspectionCommentTableViewCell.swift
//  Mechanic
//
//  Created by BYKEA - Hadi Ali on 07/12/2021.
//

import UIKit

class InspectionCommentTableViewCell: UITableViewCell, UITextViewDelegate {
    
    @IBOutlet weak var textViewParentView: UIView! {
        didSet {
            textViewParentView.layer.cornerRadius = 10
            textViewParentView.layer.borderWidth = 1
            textViewParentView.layer.borderColor = UIColor(hexString: "#BEC5D1").cgColor
        }
    }
    
    @IBOutlet weak var textView: UITextView!
    var placeholderLabel : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        textView.delegate = self
        placeholderLabel = UILabel()
        placeholderLabel.text = "Type Here"
        placeholderLabel.font = UIFont.italicSystemFont(ofSize: (textView.font?.pointSize)!)
        placeholderLabel.sizeToFit()
        textView.addSubview(placeholderLabel)
        placeholderLabel.frame.origin = CGPoint(x: 5, y: (textView.font?.pointSize)! / 2)
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.isHidden = !textView.text.isEmpty
        
    }
    
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
