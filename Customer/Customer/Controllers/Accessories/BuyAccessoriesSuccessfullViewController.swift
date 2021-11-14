//
//  BuyAccessoriesSuccessfullViewController.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 08/10/2021.
//

import UIKit

class BuyAccessoriesSuccessfullViewController: HomeBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Successfull"
//        setupBackButton(color: .white)
        navigationItem.hidesBackButton = true
    }

    @IBAction func backToHomeButtonHandler(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}
