//
//  EditProfileViewController.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 01/10/2021.
//

import UIKit

class EditProfileViewController: HomeBaseViewController {
    
    @IBOutlet weak var scrollView: BaseScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Edit Profile"
        self.setupBackButton(color: .white)

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        var contentRect = CGRect.zero
        for view in scrollView.subviews {
            for subView in view.subviews {
                contentRect = contentRect.union(subView.frame)
            }
        }
        scrollView.contentSize = contentRect.size
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
