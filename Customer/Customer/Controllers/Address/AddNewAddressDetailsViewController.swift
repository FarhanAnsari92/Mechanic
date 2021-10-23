//
//  AddNewAddressDetailsViewController.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 02/10/2021.
//

import UIKit
import GoogleMaps

class AddNewAddressDetailsViewController: HomeBaseViewController {
    
    @IBOutlet weak var txtStreet: UITextField!
    @IBOutlet weak var gmsMapView: GMSMapView! {
        didSet {
            gmsMapView.layer.cornerRadius = 15
            gmsMapView.animate(toZoom: 18)
            gmsMapView.delegate = self
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
    var location: CLLocationCoordinate2D?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add New Address"
        self.setupBackButton(color: .white)
        locationManager.getCurrentLocation { [weak self] response in
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
                self?.location = position
                self?.gmsMapView.animate(toLocation: position)
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
    
    @IBAction func saveButtonHandler(_ sender: UIButton) {
        saveAddress()
    }
    
    func saveAddress() {
        var params = [String:String]()
        params["title"] = "FB Area"
        params["address"] = "Block 1"
        params["street"] = txtStreet.text ?? ""
        params["city_id"] = "1"
        params["latitude"] = self.location?.latitude.description
        params["longitude"] = self.location?.longitude.description
        params["is_default"] = "true"
        
        print("params - ", params)
        
        APIClient.callApi(api: .address, parameters: params, method: .post, view: self.view) { [weak self] data in
            if let dictionary = data, let addressResponseModel = ObjectMapperManager<AddressResponseModel>().map(dictionary: dictionary) {
                if addressResponseModel.success ?? false {
                    self?.navigationController?.popViewController(animated: true)
                }
            }
        }
    }

}

extension AddNewAddressDetailsViewController: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        print(position.target)
        self.location = position.target
    }
    
}
