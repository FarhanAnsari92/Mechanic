//
//  ContactUsViewController.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 01/10/2021.
//

import UIKit

class ContactUsViewController: HomeBaseViewController {
    
    @IBOutlet weak var contantNumberParentView: UIView! {
        didSet {
            contantNumberParentView.dropShadow()
            contantNumberParentView.layer.cornerRadius = 10
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Contact Us"
        self.setupBackButton(color: .white)
    }
    
    @IBAction func callNowButtonHandler(_ sender: UIButton) {
        print("callNowButtonHandler")
    }

}
