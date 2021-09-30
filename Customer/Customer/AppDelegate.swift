//
//  AppDelegate.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 22/09/2021.
//

import UIKit
import IQKeyboardManagerSwift
import LGSideMenuController

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    static var instance: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        IQKeyboardManager.shared.enable = true
        print("UIDevice.current.systemVersion - ", UIDevice.current.systemVersion)
//        let sb = UIStoryboard(storyboard: .home)
//        if let homeVC = sb.instantiateViewController(withIdentifier: HomeViewController.storyboardIdentifier) as? HomeViewController {
//            let leftMenu = sb.instantiateViewController(withIdentifier: LeftMenuViewController.storyboardIdentifier)
//            
//            let homeNav = HomeBaseNavigationController(rootViewController: homeVC)
//            
//            let sideMenuController =
//                LGSideMenuController(rootViewController: homeNav,
//                                     leftViewController: leftMenu)
//            
//            sideMenuController.leftViewPresentationStyle = .scaleFromLittle
//            sideMenuController.rootView?.layer.cornerRadius = 20
//            sideMenuController.rootViewLayerShadowColor = .clear
//            sideMenuController.rootViewLayerShadowRadius = 0
//            sideMenuController.isLeftViewSwipeGestureEnabled = false
//            let sceenWidth = UIScreen.main.bounds.width
//            sideMenuController.leftViewWidth = sceenWidth - (sceenWidth / 4)
//            sideMenuController.leftViewBackgroundColor = UIColor.Theme.green
//            self.setRootViewController(sideMenuController)
//        }
        return true
    }
    
    func setRootViewController(_ controller: UIViewController) {
        guard let window = self.window else { return }
        window.makeKeyAndVisible()
        UIView.transition(with: window,
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: nil,
                          completion: nil)
        
        window.rootViewController = controller
    }

}

