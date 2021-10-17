//
//  VerifyNumberViewController.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 25/09/2021.
//

import UIKit
import LGSideMenuController

class VerifyNumberViewController: BaseViewController {
    
    @IBOutlet weak var lblResendNow: AppLinkLabel!
    @IBOutlet weak var btnConfirm: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Register"
        self.setupBackButton(color: .black)
        
        lblResendNow.link = "Resend Now"
        lblResendNow.text = "Did not receive yet? Resend Now"
        lblResendNow.didSelectLink = { link in
            print("link ----- ", (link?.absoluteString ?? ""))
        }
    }
    
    @IBAction func confirmButtonHandler(_ sender: UIButton) {
        AppRoute.navigateUserAppropriately();
    }

}
