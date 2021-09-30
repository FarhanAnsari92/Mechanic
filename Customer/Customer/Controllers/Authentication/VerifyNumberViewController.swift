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
        let sb = UIStoryboard(storyboard: .home)
        if let homeVC = sb.instantiateViewController(withIdentifier: HomeViewController.storyboardIdentifier) as? HomeViewController {
            let leftMenu = sb.instantiateViewController(withIdentifier: LeftMenuViewController.storyboardIdentifier)
            
            let homeNav = HomeBaseNavigationController(rootViewController: homeVC)
            
            let sideMenuController =
                LGSideMenuController(rootViewController: homeNav,
                                     leftViewController: leftMenu)
            
            sideMenuController.leftViewPresentationStyle = .scaleFromLittle
            sideMenuController.rootView?.layer.cornerRadius = 20
            sideMenuController.rootViewLayerShadowColor = .clear
            sideMenuController.rootViewLayerShadowRadius = 0
            sideMenuController.isLeftViewSwipeGestureEnabled = false
            
            sideMenuController.leftViewWidth = view.frame.width - (view.frame.width / 4)
            sideMenuController.leftViewBackgroundColor = UIColor.Theme.green
            AppDelegate.instance.setRootViewController(sideMenuController)
        }
    }

}
