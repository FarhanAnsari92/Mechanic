//
//  ProfileViewController.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 01/10/2021.
//

import UIKit

class ProfileViewController: HomeBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "My Profile"
        self.setupBackButton(color: .white)
    }
    
    @IBAction func editButtonHandler(_ sender: UIButton) {
        let sb = UIStoryboard(storyboard: .profile)
        let vc = sb.instantiateViewController(withIdentifier: EditProfileViewController.storyboardIdentifier)
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
