//
//  LoginViewController.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 23/09/2021.
//

import UIKit

class LoginViewController: BaseViewController {
    
    @IBOutlet weak var txtEmailAddress: AuthTextField!
    @IBOutlet weak var txtPassword: AuthTextField!
    
    @IBOutlet weak var btnLogin: UIButton! {
        didSet {
            btnLogin.layer.cornerRadius = 10
            btnLogin.backgroundColor = UIColor.Theme.green
        }
    }
    @IBOutlet weak var btnLoginWithGoogle: UIButton! {
        didSet {
            btnLoginWithGoogle.layer.cornerRadius = 10
            btnLoginWithGoogle.backgroundColor = .lightGray
        }
    }
    @IBOutlet weak var lblRegisterNow: InteractiveLinkLabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupBackButton()

        let skipButton = UIBarButtonItem(title: "Skip", style: .plain, target: self, action: #selector(self.skipButtonHandler))
        
        let font = UIFont.Poppins(UIFont.FontType.semiBold, size: 14.0)
        skipButton.setTitleTextAttributes([NSAttributedString.Key.font: font], for: UIControl.State.normal)
        
        skipButton.tintColor = UIColor.Theme.green
        self.navigationItem.rightBarButtonItem = skipButton
        
        self.title = "Login"
        
        self.setupRegisterNowLabel()
    }
    
    func setupRegisterNowLabel() {
        
        //Don't Have an Account yet? Register Now
        
        let plainText = "Don't Have an Account yet? "
        let tappableText = "Register Now"
        
        let plainTextColor = UIColor(hexString: "242323")
        let TappableTextColor = UIColor.Theme.green
        
        lblRegisterNow.tintColor = UIColor.Theme.green
        
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
        
        lblRegisterNow.isUserInteractionEnabled = true
        lblRegisterNow.attributedText = fullAttributedString
        lblRegisterNow.didTapAtLink = {
            // Use debounce here
            print("didTapAtLink")
        }
        
    }
    
    @objc func skipButtonHandler() {
        print("Skip")
    }        

}
