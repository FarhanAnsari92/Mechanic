//
//  RegistrationViewController.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 25/09/2021.
//

import UIKit

class RegistrationViewController: BaseViewController {

    @IBOutlet weak var scrollView: BaseScrollView!
    
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var btnLoginWithGoogle: UIButton! {
        didSet {
            btnLoginWithGoogle.layer.cornerRadius = 10
        }
    }
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtCNIC: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtMobile: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupBackButton(color: .black)
        self.setTextFieldsDelegate()
//        let skipButton = UIBarButtonItem(title: "Skip", style: .plain, target: self, action: #selector(self.skipButtonHandler))
//        
//        let font = UIFont.Poppins(UIFont.FontType.semiBold, size: 14.0)
//        skipButton.setTitleTextAttributes([NSAttributedString.Key.font: font], for: UIControl.State.normal)
//        
//        skipButton.tintColor = UIColor.Theme.green
//        self.navigationItem.rightBarButtonItem = skipButton
        
        self.title = "Register"
    }
    
    func setTextFieldsDelegate() {
        txtName.delegate = self
        txtEmail.delegate = self
        txtCNIC.delegate = self
        txtPhone.delegate = self
        txtMobile.delegate = self
        txtPassword.delegate = self
        txtConfirmPassword.delegate = self
    }

    @objc func skipButtonHandler() {
        print("Skip")
    }
    
    @IBAction func submitButtonHandler(_ sender: UIButton) {
        
        guard let name = txtName.text, name.count > 0 else {
            Helper.showMessage(text: "Name field is required.")
            return
        }
        
        guard let email = txtEmail.text, email.count > 0 else {
            Helper.showMessage(text: "Email field is required.")
            return
        }
        
        guard Validator.validate(email: email) else {
            Helper.showMessage(text: "Email must be valid.")
            return
        }
        
        guard let cnic = txtCNIC.text, cnic.count > 0 else {
            Helper.showMessage(text: "CNIC field is required.")
            return
        }
        
        guard Validator.validate(cnic: cnic) else {
            Helper.showMessage(text: "CNIC should contains 13 digits.")
            return
        }
        
        guard let mobile = txtMobile.text, mobile.count > 0 else {
            Helper.showMessage(text: "Mobile Number field is required.")
            return
        }
        
        guard Validator.validate(mobile: mobile) else {
            Helper.showMessage(text: "Mobile Number should be valid.")
            return
        }
        
        guard let password = txtPassword.text, password.count > 0 else {
            Helper.showMessage(text: "Password field is required.")
            return
        }
        
        guard password.count >= 6 else {
            Helper.showMessage(text: "Password should have at least 6 characters.")
            return
        }
        
        guard
            let cnfrmPassword = txtConfirmPassword.text,
            cnfrmPassword.count > 0,
            cnfrmPassword.count == password.count else {
            Helper.showMessage(text: "Password and Confirm Password should match.")
            return
        }
        
        var parameters = [String:String]()
        parameters["name"] = name
        parameters["email"] = txtEmail.text ?? ""
        parameters["cnic"] = cnic
        parameters["mobile_no"] = mobile
        parameters["phone"] = txtPhone.text ?? ""
        parameters["password"] = password
        parameters["password_confirmation"] = cnfrmPassword
        parameters["device_token"] = "DummyToken"
        parameters["device_type"] = Constants.Device.type
        #if Customer
        parameters["role"] = Constants.Role.user
        #else
        parameters["role"] = Constants.Role.mechanic
        #endif
        
        print("parameters - ", parameters)
        
        APIClient.callApi(api: .registration, parameters: parameters, method: .post, view: self.view) { data in
            if let dictionary = data,
               let object = ObjectMapperManager<RegistrationDataModel>().map(dictionary: dictionary) {
                if object.success ?? false {
                    print("Navigate to OTP Screen")
                } else {
                    Helper.showMessage(text: object.message ?? "Something went wrong")
                }
            } else {
                print("Unable to parse model.")
            }
        }
        
        
//
//        let sb = UIStoryboard(storyboard: .authentication)
//        let vc = sb.instantiateViewController(withIdentifier: VerifyNumberViewController.storyboardIdentifier)
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension RegistrationViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let originalText = textField.text as NSString?
        guard let newString = originalText?.replacingCharacters(in: range, with: string) else {
            return false
        }
        
        switch textField {
        case txtName, txtEmail:
            return newString.count < 50
            
        case txtPassword, txtConfirmPassword:
            return newString.count < 20
            
        case txtPhone, txtMobile:
            return Validator.validate(mobile: newString)
            
        case txtCNIC:
            return Validator.validate(cnic: newString)
        default:
            return true
        }
    }
    
}

class BaseScrollView: UIScrollView {

    override func touchesShouldCancel(in view: UIView) -> Bool {
        if view.isKind(of: UIButton.self) {
          return true
        }

        return super.touchesShouldCancel(in: view)
    }
}
