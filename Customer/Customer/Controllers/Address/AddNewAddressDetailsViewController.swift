//
//  AddNewAddressDetailsViewController.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 02/10/2021.
//

import UIKit
import GoogleMaps

class AddNewAddressDetailsViewController: HomeBaseViewController {
    
    @IBOutlet weak var gmsMapView: GMSMapView! {
        didSet {
            gmsMapView.layer.cornerRadius = 15
            gmsMapView.animate(toZoom: 18)
        }
    }
    @IBOutlet weak var reverseGeocodedAddressParentView: UIView! {
        didSet {
            reverseGeocodedAddressParentView.layer.cornerRadius = 10
            reverseGeocodedAddressParentView.layer.borderWidth = 1
            reverseGeocodedAddressParentView.layer.borderColor = UIColor(hexString: "BEC5D1").cgColor
        }
    }
    @IBOutlet weak var streetAddressParentView: UIView! {
        didSet {
            streetAddressParentView.layer.cornerRadius = 10
            streetAddressParentView.layer.borderWidth = 1
            streetAddressParentView.layer.borderColor = UIColor(hexString: "BEC5D1").cgColor
        }
    }
    @IBOutlet weak var scrollView: UIScrollView!

    let locationManager = LocationManager(withAccuracy: .bestForNavigation)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add New Address"
        self.setupBackButton(color: .white)
        locationManager.getCurrentLocation { response in
            switch response {
            case .failure(let locationError):
                switch locationError {
                case .authorizationFailed(let description):
                    print(description)
                case .locationUpdationFailed(let description):
                    print(description)
                }
            case .success(let location):
                print("location is :", location)
                let position = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                self.gmsMapView.animate(toLocation: position)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        var contentRect = CGRect.zero
        for view in scrollView.subviews {
            for subView in view.subviews {
                contentRect = contentRect.union(subView.frame)
            }
        }
        contentRect.size.height += 10.0
        scrollView.contentSize = contentRect.size
    }

}
