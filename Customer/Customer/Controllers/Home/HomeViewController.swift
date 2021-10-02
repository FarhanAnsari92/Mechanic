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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTitle()
        setupLeftBarButtons()
        setupRightBarButtons()
        
        if let glController = AppDelegate.instance.window?.rootViewController as? LGSideMenuController {
            if let leftMenuControllerr = glController.leftViewController as? LeftMenuViewController {
                leftMenuControllerr.leftMenuDelegate = self
            }
        }
    }
    
    func setupLeftBarButtons() {
        let leftMenuBtn = UIBarButtonItem(image: UIImage(named: "ic_side_menu"), style: .plain, target: self, action: #selector(self.openLeftMenu))
        leftMenuBtn.tintColor = .black

        let leftChatBtn = UIBarButtonItem(image: UIImage(named: "ic_chat"), style: .plain, target: self, action: #selector(self.openChat))
        leftChatBtn.tintColor = .black
        navigationItem.leftBarButtonItems = [leftMenuBtn, leftChatBtn]
    }
    
    func setupRightBarButtons() {
        let rightNotificationBtn = UIBarButtonItem(image: UIImage(named: "ic_bell"), style: .plain, target: self, action: #selector(self.openNotifications))
        rightNotificationBtn.tintColor = .black

        let rightCartBtn = UIBarButtonItem(image: UIImage(named: "ic_cart"), style: .plain, target: self, action: #selector(self.openCart))
        rightCartBtn.tintColor = .black
        navigationItem.rightBarButtonItems = [rightCartBtn, rightNotificationBtn]
    }
    
    @objc func openLeftMenu() {
        if let glController = AppDelegate.instance.window?.rootViewController as? LGSideMenuController {
            if let leftMenuControllerr = glController.leftViewController as? LeftMenuViewController {
                leftMenuControllerr.leftMenuDelegate = self
            }
            glController.showLeftView(animated: true, completion: nil)
        }
    }
    
    @objc func openChat() {
        print("openChat")
    }
    
    @objc func openNotifications() {
        print("openNotifications")
    }
    @objc func openCart() {
        print("openNotifications")
    }
    
    func setupTitle() {
        let imageName = "ic_motor_service"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
    }

}

extension HomeViewController: LeftMenuContainerViewControllerDelegate {
    
    func didSelect(_ title: LeftMenuType) {
        switch title {
        case .home:
            print(title.rawValue)
        case .myProfile:
            let sb = UIStoryboard(storyboard: .profile)
            let vc = sb.instantiateViewController(withIdentifier: ProfileViewController.storyboardIdentifier)
            self.navigationController?.pushViewController(vc, animated: true)
        case .address:
            let sb = UIStoryboard(storyboard: .address)            
            let vc = sb.instantiateViewController(withIdentifier: AddressListViewController.storyboardIdentifier)
            
            self.navigationController?.pushViewController(vc, animated: true)
        case .track:
            let sb = UIStoryboard(storyboard: .tracking)
            let vc = sb.instantiateViewController(withIdentifier: TrackingViewController.storyboardIdentifier)
            self.navigationController?.pushViewController(vc, animated: true)
        case .orderHistory:
            
            let sb = UIStoryboard(storyboard: .order)
            let vc = sb.instantiateViewController(withIdentifier: OrderHistoryViewController.storyboardIdentifier)
            self.navigationController?.pushViewController(vc, animated: true)
            
        case .termAndConditions:
            print(title.rawValue)
        case .contact:
            
            let sb = UIStoryboard(storyboard: .contact)
            let vc = sb.instantiateViewController(withIdentifier: ContactUsViewController.storyboardIdentifier)
            self.navigationController?.pushViewController(vc, animated: true)
            
        case .logout:
            let sb = UIStoryboard(storyboard: .authentication)
            if let vc = sb.instantiateInitialViewController() {
                AppDelegate.instance.setRootViewController(vc)
            }
        }
    }
    
}
