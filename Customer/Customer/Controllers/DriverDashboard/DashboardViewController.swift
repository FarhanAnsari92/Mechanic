//
//  DashboardViewController.swift
//  Mechanic
//
//  Created by BYKEA - Hadi Ali on 30/11/2021.
//

import UIKit
import LGSideMenuController

class DashboardViewController: HomeBaseViewController {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var segmentControl: UISegmentedControl!

    lazy var pickupDashboardController: UIViewController? = {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: DashBoardPickupViewController.storyboardIdentifier)
        return controller
    }()
    
    lazy var dropoffDashboardController: UIViewController? = {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: DashBoardDropViewController.storyboardIdentifier)
        return controller
    }()
    
    var currentController: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Dashboard"
        view.backgroundColor = UIColor.Theme.green
        segmentControl.setupDashboardSegment()
        self.switchController(self.pickupDashboardController)
        setupLeftBarButtons()
        setupRightBarButtons()
        
    }
    
    @IBAction func didTabSegment(sigment: UISegmentedControl) {
        print("sigment.selectedSegmentIndex - ", sigment.selectedSegmentIndex)
        if sigment.selectedSegmentIndex == 0 {
            self.switchController(self.pickupDashboardController)
        } else {
            self.switchController(self.dropoffDashboardController)
        }
        print(self.currentController)
    }
    
    func switchController(_ controller: UIViewController?) {
        guard let vc = controller, vc != self.currentController else {
            return
        }
        
        self.addChild(vc)
        vc.didMove(toParent: self)
        vc.view.frame = self.containerView.bounds
        self.containerView.addSubview(vc.view)
        self.currentController = vc
        
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
