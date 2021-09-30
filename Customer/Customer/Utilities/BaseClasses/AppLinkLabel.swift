//
//  AppLinkLabel.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 30/09/2021.
//

import UIKit
import TTTAttributedLabel

struct AttributedLink {
    let url: URL
    let range: NSRange
}

struct AttributedLabel {
    let attributedText: NSAttributedString
    let linkAttributes: [String: Any]
    let activeLinkAttributes: [String: Any]
    let links: [AttributedLink]
}

class AppLinkLabel: TTTAttributedLabel, TTTAttributedLabelDelegate {
    
    var link: String?
    var didSelectLink: ((URL?) -> Void)?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.delegate = self
        self.setupAttributes()
    }
    
    func setupAttributes() {
        let tappableText = link
        
        let termsAndPrivacyText: String = text as! String
        
        let termsAndPrivacyTextAttributedString = NSAttributedString(string:termsAndPrivacyText, attributes: [
            NSAttributedString.Key.font : UIFont.Poppins(.regular, size: 10),
            NSAttributedString.Key.foregroundColor: UIColor(hexString: "242323"),
        ])
        
        let termsAndPrivacyLinkAttributes = [
            NSAttributedString.Key.foregroundColor.rawValue: UIColor.Theme.green,
            NSAttributedString.Key.underlineStyle.rawValue: NSNumber(value:false),
        ]
        let termsAndPrivacyActiveLinkAttributes = [
            NSAttributedString.Key.foregroundColor.rawValue: UIColor.Theme.green,
            NSAttributedString.Key.underlineStyle.rawValue: NSNumber(value:false),
        ]
        
        let termsLinkRange = (termsAndPrivacyText as NSString).range(of: tappableText ?? "")
        let termsURL = URL(string: "www.google.com")!
        
        
        let links: [AttributedLink] = [
            AttributedLink(url: termsURL, range: termsLinkRange)
        ]
        
        let attributes = AttributedLabel(
            attributedText: termsAndPrivacyTextAttributedString,
            linkAttributes: termsAndPrivacyLinkAttributes,
            activeLinkAttributes: termsAndPrivacyActiveLinkAttributes,
            links: links
        )
        
        self.setText(attributes.attributedText)
        self.linkAttributes = attributes.linkAttributes
        self.activeLinkAttributes = attributes.activeLinkAttributes
        
        for link in attributes.links {
            self.addLink(to: link.url, with: link.range)
        }
        
    }
    
    func attributedLabel(_ label: TTTAttributedLabel!, didSelectLinkWith url: URL!) {
        self.didSelectLink?(url)
    }
    
}

