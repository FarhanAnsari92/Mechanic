//
//  DashboardViewController.swift
//  Mechanic
//
//  Created by BYKEA - Hadi Ali on 30/11/2021.
//

import UIKit
import LGSideMenuController

class DashboardViewController: HomeBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Dashboard"
        
        setupLeftBarButtons()
        setupRightBarButtons()
        
    }
    
    func setupLeftBarButtons() {
        let leftMenuBtn = UIBarButtonItem(image: UIImage(named: "ic_side_menu"), style: .plain, target: self, action: #selector(self.openLeftMenu))
        leftMenuBtn.tintColor = .white

        let leftChatBtn = UIBarButtonItem(image: UIImage(named: "ic_chat"), style: .plain, target: self, action: #selector(self.openChat))
        leftChatBtn.tintColor = .white
        navigationItem.leftBarButtonItems = [leftMenuBtn, leftChatBtn]
    }
    
    func setupRightBarButtons() {
        let rightNotificationBtn = UIBarButtonItem(image: UIImage(named: "ic_bell"), style: .plain, target: self, action: #selector(self.openNotifications))
        rightNotificationBtn.tintColor = .white

        navigationItem.rightBarButtonItems = [rightNotificationBtn]
    }
    
}

// MARK: Actions

extension DashboardViewController {
    
    @objc func openLeftMenu() {
        if let glController = AppDelegate.instance.window?.rootViewController as? LGSideMenuController {
            if let leftMenuControllerr = glController.leftViewController as? DriverLeftMenuViewController {
                leftMenuControllerr.leftMenuDelegate = self
            }
            glController.showLeftView(animated: true, completion: nil)
        }
    }
    
    @objc func openChat() {
        let sb = UIStoryboard(storyboard: .chat)
        let vc = sb.instantiateViewController(withIdentifier: ChatViewController.storyboardIdentifier)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func openNotifications() {
        let sb = UIStoryboard(storyboard: .notification)
        let vc = sb.instantiateViewController(withIdentifier: NotificationViewController.storyboardIdentifier)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

// MARK: LeftMenuContainerViewControllerDelegate

extension DashboardViewController: LeftMenuContainerViewControllerDelegate {
    
    func didSelect(_ title: LeftMenuType) {
        switch title {
        case .home:
            print(title.rawValue)
        case .termAndConditions:
            print(title.rawValue)
        case .contact:
            
            let sb = UIStoryboard(storyboard: .contact)
            let vc = sb.instantiateViewController(withIdentifier: ContactUsViewController.storyboardIdentifier)
            self.navigationController?.pushViewController(vc, animated: true)
            
        case .logout:
            Helper.logout()
            AppRoute.navigateUserToAuthenticate()
            
        default:
            break
        }
    }
    
}
