//
//  HomeBaseNavigationController.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 27/09/2021.
//

import UIKit

class HomeBaseNavigationController: UINavigationController {

    override func viewDidLoad() {
       super.viewDidLoad()
       setFont()
    }

    func setFont() {
        let font = UIFont.Poppins(.regular, size: 20)
        self.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: font,
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
    }


}
