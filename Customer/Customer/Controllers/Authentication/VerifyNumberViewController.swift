//
//  VerifyNumberViewController.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 25/09/2021.
//

import UIKit

class VerifyNumberViewController: BaseViewController {
    
    @IBOutlet weak var lblResendNow: InteractiveLinkLabel!
    @IBOutlet weak var btnConfirm: UIButton! {
        didSet {
            btnConfirm.layer.cornerRadius = 10
            btnConfirm.backgroundColor = UIColor.Theme.green
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Register"
        self.setupBackButton()
        self.setupRegisterNowLabel()
    }
    
    func setupRegisterNowLabel() {
        
        //Did not receive yet? Resend Now
        
        let plainText = "Did not receive yet? "
        let tappableText = "Resend Now"
        
        let plainTextColor = UIColor(hexString: "242323")
        let TappableTextColor = UIColor.Theme.green
        
        lblResendNow.tintColor = UIColor.Theme.green
        
        let plainAttributedString = NSMutableAttributedString(string: plainText, attributes: [.foregroundColor: plainTextColor])
        
        let attributedLinkString = NSMutableAttributedString(string: tappableText,
                                                             attributes:[
//                                                                .link: URL(string: "http://www.google.com")!,
                                                                .foregroundColor: TappableTextColor,
                                                                .strokeColor: UIColor.clear,
                                                                NSAttributedString.Key.underlineColor: UIColor.clear
                                                             ])
        let fullAttributedString = NSMutableAttributedString()
        fullAttributedString.append(plainAttributedString)
        fullAttributedString.append(attributedLinkString)
        
        lblResendNow.isUserInteractionEnabled = true
        lblResendNow.attributedText = fullAttributedString
        lblResendNow.didTapAtLink = {
            // Use debounce here
            print("didTapAtLink")
        }
        
    }
    
    @IBAction func confirmButtonHandler(_ sender: UIButton) {
        let sb = UIStoryboard(storyboard: .vehicle)
        let vc = sb.instantiateViewController(withIdentifier: MyVehicleViewController.storyboardIdentifier)
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
