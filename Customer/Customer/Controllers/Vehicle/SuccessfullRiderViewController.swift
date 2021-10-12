//
//  SuccessfullRiderViewController.swift
//  Customer
//
//  Created by Mohammad Farhan on 10/13/21.
//

import UIKit

class SuccessfullRiderViewController: HomeBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Successfull"
        setupBackButton(color: . white)
    }
    

    @IBAction func backToHomeButtonHandler( _ sender: UIButton){
           
        self.navigationController?.popToRootViewController(animated: true)
       }
  

}
