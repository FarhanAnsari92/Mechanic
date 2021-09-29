//
//  HomeBaseViewController.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 26/09/2021.
//

import UIKit

class HomeBaseViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor.Theme.green
    }

}
