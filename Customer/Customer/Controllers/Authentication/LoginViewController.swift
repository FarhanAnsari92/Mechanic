//
//  LoginViewController.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 23/09/2021.
//

import UIKit

class LoginViewController: BaseViewController {
    
    @IBOutlet weak var txtPhoneNumber: AuthTextField!
    @IBOutlet weak var txtPassword: AuthTextField!
    
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnLoginWithGoogle: UIButton! {
        didSet {
            btnLoginWithGoogle.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var lblRegisterNow: AppLinkLabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupBackButton(color: .black)

//        let skipButton = UIBarButtonItem(title: "Skip", style: .plain, target: self, action: #selector(self.skipButtonHandler))
//        
//        let font = UIFont.Poppins(UIFont.FontType.semiBold, size: 14.0)
//        skipButton.setTitleTextAttributes([NSAttributedString.Key.font: font], for: UIControl.State.normal)
//        
//        skipButton.tintColor = UIColor.Theme.green
//        self.navigationItem.rightBarButtonItem = skipButton
        
        self.title = "Login"
        
        lblRegisterNow.link = "Register Now"
        lblRegisterNow.text = "Don't Have an Account yet? Register Now"
        lblRegisterNow.didSelectLink = { link in
            print("link ----- ", (link?.absoluteString ?? ""))            
        }
        
    }
    
    @objc func skipButtonHandler() {
        print("Skip")
    }
    
    @IBAction func loginButtonHandler(_ sender: UIButton) {
        
        var parameters = [String : String]()
        parameters["mobile_no"] = txtPhoneNumber.text ?? ""
        parameters["password"]  = txtPassword.text ?? ""
        parameters["device_type"] = Constants.Device.type
        parameters["device_token"] = "Dummy Token"
        
        APIClient.callApi(api: .login, parameters: parameters, method: .post, view: self.view) { data in
            if let message = data?["message"] as? String {
                Helper.showMessage(text: message)
            }
        }
    }

}
