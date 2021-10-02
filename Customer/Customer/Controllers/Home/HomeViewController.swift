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
    
    @IBOutlet weak var btnFixMyVehicle: UIButton!
    @IBOutlet weak var lblAutoParts: InteractiveLinkLabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTitle()
        setupLeftBarButtons()
        setupRightBarButtons()
        setupAutoPartsLabel()
        
        if let glController = AppDelegate.instance.window?.rootViewController as? LGSideMenuController {
            if let leftMenuControllerr = glController.leftViewController as? LeftMenuViewController {
                leftMenuControllerr.leftMenuDelegate = self
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupFixMyVehicleButton()
    }
    
}

// MARK: View Setup

extension HomeViewController {
    
    func setupTitle() {
        let imageName = "ic_motor_service"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
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
    
    func setupFixMyVehicleButton() {
        let width: CGFloat = view.frame.width - 40
        let frame = CGRect(origin: .zero, size: CGSize(width: width, height: 55))
        let fixMyVehicleView = FixMyVehicleView().loadViewFromNib()
        fixMyVehicleView.frame = frame
        
        let gradient = CAGradientLayer()
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 5.0, y: 0.0)
        gradient.colors = [
            UIColor.Theme.green.cgColor,
            UIColor.fill(red: 93, green: 197, blue: 123).cgColor
        ]
        gradient.locations = [0.0, 0.1]
        gradient.frame = frame
        fixMyVehicleView.layer.insertSublayer(gradient, at: 0)
        fixMyVehicleView.layer.masksToBounds = true
        fixMyVehicleView.layer.cornerRadius = 10
        btnFixMyVehicle.addSubview(fixMyVehicleView)
    }
    
    private func setupAutoPartsLabel() {
        
        let plainText = "1000+ Auto Parts & "
        let tappableText = "Accessories"
        
        let plainAttributedString = NSMutableAttributedString(string: plainText, attributes: [.foregroundColor: UIColor(hexString: "1F2937"), .font: UIFont.Poppins(.semiBold, size: 18)])
        
        let attributedLinkString = NSMutableAttributedString(
            string: tappableText,
            attributes:[
                .foregroundColor: UIColor(hexString: "1F2937"),
                .font: UIFont.Poppins(.regular, size: 18)
            ]
        )
        let fullAttributedString = NSMutableAttributedString()
        fullAttributedString.append(plainAttributedString)
        fullAttributedString.append(attributedLinkString)
        lblAutoParts.isUserInteractionEnabled = false
        lblAutoParts.attributedText = fullAttributedString

    }
    
}

// MARK: Actions

extension HomeViewController {
    
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
    
    @IBAction func filterButtonHandler(_ sender: UIButton) {
        print("filterButtonHandler")
    }
    
    @IBAction func searchGoButtonHandler(_ sender: UIButton) {
        print("searchGoButtonHandler")
    }
    
    @IBAction func fixMyVehicleButtonHandler(_ sender: UIButton) {
        print("fixMyVehicleButtonHandler")
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

class Colors {
    var gl:CAGradientLayer!

    init(color1: UIColor, color2: UIColor) {
        self.gl = CAGradientLayer()
        self.gl.startPoint = CGPoint(x: 0, y: 0)
        self.gl.endPoint = CGPoint(x: 1, y: 0)
        self.gl.colors = [color1.cgColor, color1.cgColor]
        self.gl.locations = [0.0, 1.0]
    }
}
