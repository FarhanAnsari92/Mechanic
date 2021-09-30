//
//  HomeViewController.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 26/09/2021.
//

import UIKit
import SideMenu
import LGSideMenuController

class HomeViewController: SideMenuBaseController {
    
//    override var sideMenuController: LGSideMenuController? {
//        if let controller = self as? LGSideMenuController {
//            return controller
//        }
//        if let controller = LGSideMenuHelper.getSideMenuController(from: self) {
//            return controller
//        }
//        if let controller = self.parent?.sideMenuController {
//            return controller
//        }
//        return nil
//    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if let glController = AppDelegate.instance.window?.rootViewController as? LGSideMenuController {
            if let leftMenuControllerr = glController.leftViewController as? LeftMenuViewController {
                leftMenuControllerr.leftMenuDelegate = self
            }
        }
        
        let leftMenuBtn = UIBarButtonItem(image: UIImage(named: "ic_side_menu"), style: .plain, target: self, action: #selector(self.openLeftMenu))
        leftMenuBtn.tintColor = .black
        navigationItem.leftBarButtonItem = leftMenuBtn
    }
    
    @objc func openLeftMenu() {
        if let glController = AppDelegate.instance.window?.rootViewController as? LGSideMenuController {
            if let leftMenuControllerr = glController.leftViewController as? LeftMenuViewController {
                leftMenuControllerr.leftMenuDelegate = self
            }
            glController.showLeftView(animated: true, completion: nil)
        }
    }

}

extension HomeViewController: LeftMenuContainerViewControllerDelegate {
    
    func didSelect(_ title: LeftMenuType) {
        switch title {
        case .home:
            print(title.rawValue)
        case .myProfile:
            print(title.rawValue)
        case .address:
            let sb = UIStoryboard(storyboard: .address)            
            let vc = sb.instantiateViewController(withIdentifier: AddressListViewController.storyboardIdentifier)
            self.navigationController?.pushViewController(vc, animated: true)
        case .track:
            print(title.rawValue)
        case .orderHistory:
            
            let sb = UIStoryboard(storyboard: .order)
            let vc = sb.instantiateViewController(withIdentifier: OrderHistoryViewController.storyboardIdentifier)
            self.navigationController?.pushViewController(vc, animated: true)
            
        case .termAndConditions:
            print(title.rawValue)
        case .contact:
            print(title.rawValue)
        case .logout:
            let sb = UIStoryboard(storyboard: .authentication)
            if let vc = sb.instantiateInitialViewController() {
                AppDelegate.instance.setRootViewController(vc)
            }
        }
    }
    
}
