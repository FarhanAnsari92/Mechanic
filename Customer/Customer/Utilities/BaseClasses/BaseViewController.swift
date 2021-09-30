//
//  BaseViewController.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 22/09/2021.
//

import UIKit
import LGSideMenuController

protocol Transparetable {
    func makeTransparent()
}

extension Transparetable where Self: UIViewController {
    func makeTransparent() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = .white
    }
}

class BaseViewController: UIViewController, Transparetable {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.makeTransparent()
    }
}

class SideMenuBaseController: LGSideMenuController, Transparetable {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.makeTransparent()
    }
}
