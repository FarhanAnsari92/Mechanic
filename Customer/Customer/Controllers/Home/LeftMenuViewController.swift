//
//  LeftMenuViewController.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 28/09/2021.
//

import UIKit
import LGSideMenuController

enum LeftMenuType: String {
    case home = "Home"
    case myProfile = "My Profile"
    case address = "Address"
    case track = "Track"
    case orderHistory = "Order History"
    case termAndConditions = "T&Cs"
    case contact = "Contact"
    case logout = "Logout"
}

struct LeftMenuData {
    var title: LeftMenuType
    var image: UIImage
    var shouldHideUpperLine: Bool
    var shouldHideLowerLine: Bool
    
    init(
        imageName: String,
        title: LeftMenuType,
        shouldHideUpperLine: Bool = true,
        shouldHideLowerLine: Bool = true
    ) {
        self.image = UIImage(named: imageName)!
        self.title = title
        self.shouldHideUpperLine = shouldHideUpperLine
        self.shouldHideLowerLine = shouldHideLowerLine
    }
}

protocol LeftMenuContainerViewControllerDelegate: NSObjectProtocol {
    func didSelect(_ title: LeftMenuType)
}

class LeftMenuViewController: UIViewController {
    
    @IBOutlet weak var imgProfile: UIImageView! {
        didSet {
            imgProfile.roundView()
            imgProfile.layer.borderWidth = 5
            imgProfile.layer.borderColor = UIColor.white.cgColor
        }
    }
    @IBOutlet weak var lblProfile: UILabel!
    @IBOutlet weak var lblRewardPoints: UILabel!
    @IBOutlet weak var rewardPointsParentView: UIView! {
        didSet {
            rewardPointsParentView.layer.cornerRadius = rewardPointsParentView.frame.height / 2
        }
    }
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.backgroundColor = .clear
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(LeftMenuTableViewCell.nib, forCellReuseIdentifier: LeftMenuTableViewCell.identifier)
        }
    }

    var cellData: [LeftMenuData] = [LeftMenuData]()
    weak var leftMenuDelegate: LeftMenuContainerViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.Theme.green
        
        cellData.append(LeftMenuData(imageName: "ic_side_home", title: .home))
        cellData.append(LeftMenuData(imageName: "ic_side_profile", title: .myProfile))
        cellData.append(LeftMenuData(imageName: "ic_side_pin", title: .address))
        cellData.append(LeftMenuData(imageName: "ic_side_search", title: .track))
        cellData.append(LeftMenuData(imageName: "ic_side_order_history", title: .orderHistory))
        cellData.append(LeftMenuData(imageName: "ic_side_terms", title: .termAndConditions))
        cellData.append(LeftMenuData(imageName: "ic_side_phone", title: .contact, shouldHideLowerLine: false))
        cellData.append(LeftMenuData(imageName: "ic_side_logout", title: .logout))
        
        setupRewardLabel()

    }
    
    func setupRewardLabel() {
        
        let reward = "345 "
        let rewardText = "Reward Points"
        
        let rewardFont = UIFont.Poppins(.semiBold, size: 12)
        let rewardTextFont = UIFont.Poppins(.regular, size: 12)
        
        
        let rewardAttributedString = NSMutableAttributedString(string: reward, attributes: [.font: rewardFont])
        
        let rewardTextAttributedString = NSMutableAttributedString(string: rewardText,
                                                             attributes:[
                                                                .font: rewardTextFont
                                                             ])
        let fullAttributedString = NSMutableAttributedString()
        fullAttributedString.append(rewardAttributedString)
        fullAttributedString.append(rewardTextAttributedString)
        
        lblRewardPoints.isUserInteractionEnabled = true
        lblRewardPoints.attributedText = fullAttributedString
        
    }

}

extension LeftMenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cellData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: LeftMenuTableViewCell.identifier, for: indexPath) as! LeftMenuTableViewCell
        let data = self.cellData[indexPath.row]
        cell.imageVU.image = data.image
        cell.lblTitle.text = data.title.rawValue
        cell.upperLine.isHidden = data.shouldHideUpperLine
        cell.lowerLine.isHidden = data.shouldHideLowerLine
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let glController = AppDelegate.instance.window?.rootViewController as? LGSideMenuController
        glController?.toggleLeftView()
        let data = self.cellData[indexPath.row]
        self.leftMenuDelegate?.didSelect(data.title)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.cellData[indexPath.row].title == .logout {        
            return 65
        }
        return 45
    }
    
}
