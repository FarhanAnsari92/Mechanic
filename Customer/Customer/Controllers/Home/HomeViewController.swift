//
//  HomeViewController.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 26/09/2021.
//

import UIKit
import SideMenu

class HomeViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationController?.delegate = self
        
        let leftMenuBtn = UIBarButtonItem(image: UIImage(named: "ic_side_menu"), style: .plain, target: self, action: #selector(self.openLeftMenu))
        leftMenuBtn.tintColor = .black
        navigationItem.leftBarButtonItem = leftMenuBtn
    }
    
    @objc func openLeftMenu() {
        
        let sb = UIStoryboard(storyboard: .home)
        let leftRootVC = sb.instantiateViewController(withIdentifier: LeftMenuViewController.storyboardIdentifier) as! LeftMenuViewController
        leftRootVC.delegate = self
        
        let leftMenuNavigationController = SideMenuNavigationController(rootViewController: leftRootVC)
        leftMenuNavigationController.setNavigationBarHidden(true, animated: false)
        leftMenuNavigationController.leftSide = true
        leftMenuNavigationController.presentationStyle = .menuSlideIn
//        leftMenuNavigationController.blurEffectStyle = .regular
        leftMenuNavigationController.menuWidth = self.view.bounds.width * 0.8
        self.present(leftMenuNavigationController, animated: true, completion: nil)
        
    }
    
    @IBAction func orderList(_ sender: UIButton) {
        let sb = UIStoryboard(storyboard: .order)
        let vc = sb.instantiateViewController(withIdentifier: OrderHistoryViewController.storyboardIdentifier)
        self.navigationController?.pushViewController(vc, animated: true)
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
            print(title.rawValue)
        case .track:
            print(title.rawValue)
        case .orderHistory:
            print(title.rawValue)
        case .termAndConditions:
            print(title.rawValue)
        case .contact:
            print(title.rawValue)
        case .logout:
            let sb = UIStoryboard(storyboard: .authentication)
            let vc = sb.instantiateInitialViewController()
            guard let window = Helper.appDelegate.window else { return }
            
            window.makeKeyAndVisible()
                UIView.transition(with: window,
                                  duration: 0.3,
                                  options: .transitionCrossDissolve,
                                  animations: nil,
                                  completion: nil)
            
            window.rootViewController = vc
        }
    }
    
}
