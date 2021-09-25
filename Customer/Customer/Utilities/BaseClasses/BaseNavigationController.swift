//
//  BaseNavigationController.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 25/09/2021.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
       super.viewDidLoad()
       setFont()
    }

    func setFont() {
        let font = UIFont.Poppins(.regular, size: 20)
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: font]        
    }

}

extension Int {
    func convertToDollor() -> String {
        return "\(self)$"
    }
}
