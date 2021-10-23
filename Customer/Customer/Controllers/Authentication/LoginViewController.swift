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
        setupTextFieldsDelegate()
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
    
    func setupTextFieldsDelegate() {
        txtPhoneNumber.delegate = self
        txtPassword.delegate = self
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
            
            if let dictionary = data,
               let object = ObjectMapperManager<RegistrationDataModel>().map(dictionary: dictionary) {
                if object.success ?? false {
                    if let user = object.data?.user {
                        Helper.save(user: user)
                        AppRoute.navigateUserAppropriately()
                    }
                } else {
                    Helper.showMessage(text: object.message ?? "Something went wrong.")
                }
            } else {
                Helper.showMessage(text: "Something went wrong.")
            }
        }
    }

}

extension LoginViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let originalText = textField.text as NSString?
        guard let newString = originalText?.replacingCharacters(in: range, with: string) else {
            return false
        }
        
        switch textField {            
        case txtPassword:
            return newString.count < 20
            
        case txtPhoneNumber:
            return Validator.validate(mobile: newString)
            
        default:
            return true
        }
    }
    
}
