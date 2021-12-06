//
//  MapViewController.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 06/12/2021.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController {
    
    @IBOutlet weak var gmsMapView: GMSMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "MAP"
        self.setupBackButton(color: .white)
        self.setupCallButton()
    }
    
    func setupCallButton() {
        let backBtn = UIBarButtonItem(image: UIImage(named: "ic_call"), style: .plain, target: self, action: #selector(self.callButtonHandler))
        backBtn.tintColor = .white
        navigationItem.rightBarButtonItem = backBtn
    }
    
    @objc private func callButtonHandler() {
        print("call")
    }
    
    @IBAction func reachedDestinationButtonHandler(_ sender: UIButton) {
        let sb = UIStoryboard(storyboard: .dashboard)
        let vc = sb.instantiateViewController(withIdentifier: InspectDetailsViewController.storyboardIdentifier)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func cancelTaskButtonHandler(_ sender: UIButton) {
        print("cancel")
    }

}
