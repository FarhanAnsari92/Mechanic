//
//  InitialViewController.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 22/09/2021.
//

import UIKit
import ZSWTappableLabel

class InitialViewController: BaseViewController {
    
    @IBOutlet weak var btnCreateAccount: UIButton! {
        didSet {
            btnCreateAccount.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var btnLogin: UIButton! {
        didSet {
            btnLogin.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var lblTermsAndCondition: InteractiveLinkLabel!
    @IBOutlet weak var lblDescription: UILabel! {
        didSet {
            lblDescription.text = "Before using our Services\n Please Register First"
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let skipButton = UIBarButtonItem(title: "Skip", style: .plain, target: self, action: #selector(self.skipButtonHandler))
        
        let font = UIFont.Poppins(.semiBold, size: 14.0)
        skipButton.setTitleTextAttributes([NSAttributedString.Key.font: font], for: UIControl.State.normal)
        
        skipButton.tintColor = UIColor.Theme.green
        self.navigationItem.rightBarButtonItem = skipButton                
        
        self.setupTermsAndConditionLabel()
    }
    
    func setupTermsAndConditionLabel() {
        
        //By logging in or registering, you have agreed to the Terms and Conditions and Privacy Policy.
        
        let plainText = "By logging in or registering, you have agreed to "
        let tappableText = "the Terms and Conditions and Privacy Policy."
        
        let plainTextColor = UIColor(hexString: "242323")
        let TappableTextColor = UIColor.Theme.green
        
        lblTermsAndCondition.tintColor = UIColor.Theme.green
        
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
        
        lblTermsAndCondition.isUserInteractionEnabled = true
        lblTermsAndCondition.attributedText = fullAttributedString
        lblTermsAndCondition.didTapAtLink = {
            // Use debounce here
            print("didTapAtLink")
        }
        
    }
    
    @objc func skipButtonHandler() {
        print("Skip")
    }
    
    @IBAction func createAccountButtonHandler(_ sender: UIButton) {
        let sb = UIStoryboard(storyboard: .authentication)
        let vc = sb.instantiateViewController(withIdentifier: RegistrationViewController.storyboardIdentifier)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func loginButtonHandler(_ sender: UIButton) {        
        let sb = UIStoryboard(storyboard: .authentication)
        let vc = sb.instantiateViewController(withIdentifier: LoginViewController.storyboardIdentifier)
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
