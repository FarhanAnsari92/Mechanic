//
//  AppRoute.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 17/10/2021.
//

import UIKit
import LGSideMenuController

class AppRoute {
    
    class func setRootViewController(_ controller: UIViewController) {
        guard let window = AppDelegate.instance.window else { return }
        window.makeKeyAndVisible()
        UIView.transition(with: window,
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: nil,
                          completion: nil)
        
        window.rootViewController = controller
    }
    
    class func navigateUserAppropriately() {
        if let _ = Helper.getUser() {
            let sb = UIStoryboard(storyboard: .home)
            if let homeVC = sb.instantiateViewController(withIdentifier: HomeViewController.storyboardIdentifier) as? HomeViewController {
                let leftMenu = sb.instantiateViewController(withIdentifier: LeftMenuViewController.storyboardIdentifier)
                
                let homeNav = HomeBaseNavigationController(rootViewController: homeVC)
                
                let sideMenuController =
                    LGSideMenuController(rootViewController: homeNav,
                                         leftViewController: leftMenu)
                
                sideMenuController.leftViewPresentationStyle = .scaleFromLittle
                sideMenuController.isLeftViewStatusBarHidden = true
                sideMenuController.rootView?.layer.cornerRadius = 20
                sideMenuController.rootViewLayerShadowColor = .clear
                sideMenuController.rootViewLayerShadowRadius = 0
                sideMenuController.isLeftViewSwipeGestureEnabled = false
                let sceenWidth = UIScreen.main.bounds.width
                sideMenuController.leftViewWidth = sceenWidth * 0.75 // - (sceenWidth / 4)
                sideMenuController.leftViewBackgroundColor = UIColor.Theme.green
                AppRoute.setRootViewController(sideMenuController)
            }
        }
    }
    
    class func navigateUserToAuthente() {
        let sb = UIStoryboard(storyboard: .authentication)
        if let vc = sb.instantiateInitialViewController() {
            AppRoute.setRootViewController(vc)
        }
    }
    
}
