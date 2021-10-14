//
//  InitialViewController.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 22/09/2021.
//

import UIKit

class InitialViewController: BaseViewController {
    
    @IBOutlet weak var btnCreateAccount: UIButton!
    @IBOutlet weak var btnLogin: UIButton! {
        didSet {
            btnLogin.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var lblTermsAndCondition: AppLinkLabel!
    @IBOutlet weak var lblDescription: UILabel! {
        didSet {
            lblDescription.text = "Before using our Services\n Please Register First"
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let skipButton = UIBarButtonItem(title: "Skip", style: .plain, target: self, action: #selector(self.skipButtonHandler))
//        
//        let font = UIFont.Poppins(.semiBold, size: 14.0)
//        skipButton.setTitleTextAttributes([NSAttributedString.Key.font: font], for: UIControl.State.normal)
//        
//        skipButton.tintColor = UIColor.Theme.green
//        self.navigationItem.rightBarButtonItem = skipButton                
        
        self.lblTermsAndCondition.link = "the Terms and Conditions and Privacy Policy."
        self.lblTermsAndCondition.text = "By logging in or registering, you have agreed to the Terms and Conditions and Privacy Policy."
        self.lblTermsAndCondition.didSelectLink = { link in
            print("Link ----- ", (link?.absoluteString ?? "Link not provided"))
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
