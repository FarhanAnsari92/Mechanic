//
//  HomeViewController.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 26/09/2021.
//

import UIKit

class HomeViewController: HomeBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.delegate = self
    }
    
    @IBAction func orderList(_ sender: UIButton) {
        let sb = UIStoryboard(storyboard: .order)
        let vc = sb.instantiateViewController(withIdentifier: OrderHistoryViewController.storyboardIdentifier)
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
