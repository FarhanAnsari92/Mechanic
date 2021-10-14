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
        
        self.title = "Register"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        var contentRect = CGRect.zero
        for view in scrollView.subviews {
            for subView in view.subviews {
                contentRect = contentRect.union(subView.frame)
            }
        }
        scrollView.contentSize = contentRect.size
    }

    @objc func skipButtonHandler() {
        print("Skip")
    }
    
    @IBAction func submitButtonHandler(_ sender: UIButton) {
        let sb = UIStoryboard(storyboard: .authentication)
        let vc = sb.instantiateViewController(withIdentifier: VerifyNumberViewController.storyboardIdentifier)
        self.navigationController?.pushViewController(vc, animated: true)
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
