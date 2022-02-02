//
//  MapViewController.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 25/01/2022.
//

import UIKit
import GoogleMaps

protocol ChatInitiable {
    var threadId: String { get set }
}

class TrackMapViewControllerViewModel: ChatInitiable {
    var threadId: String
    var jobId: String
    
    private var rideLocationSuccess: (([Any]) -> Void)?
    
    init(jobId: String, threadId: String) {
        self.jobId = jobId
        self.threadId = threadId
    }
    
    func getRiderLastLocation(completion: (([Any]) -> Void)?) {
        
        if let userId = Helper.getUser()?.id {
            self.rideLocationSuccess = completion
            SocketIOManager.shared.emit(.getRiderLastLocation, parameters: ["user_id" :userId])
            SocketIOManager.shared.on(.riderLocationSuccess) { [weak self] (data, ack) in
                self?.rideLocationSuccess?(data)
            }
        }
    }
    
    func startListeningRiderLocation(completion: ((CLLocationCoordinate2D) -> Void)?) {
        SocketIOManager.shared.on(.notifyUserNewRiderLocation) { (data, ack) in
            if let arr = data as? [[String:Any]],
               let firstObj = arr.first,
               let rawData = firstObj["data"] as? [String:Any],
               let strLatitude = rawData["latitude"] as? String,
               let strLongitude = rawData["longitude"] as? String,
               let latitude = Double(strLatitude),
               let longitude = Double(strLongitude) {
                let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                completion?(coordinate)
            }
        }
    }
    
    func stopListen() {
        SocketIOManager.shared.off(.notifyUserNewRiderLocation)
        SocketIOManager.shared.off(.riderLocationSuccess)
    }
    
}

class TrackMapViewController: HomeBaseViewController {
    
    @IBOutlet weak var mapView: GMSMapView! {
        didSet {
            mapView.animate(toZoom: 18)
        }
    }
    
    let destinationMarker = GMSMarker()
    var lastUpdatedLocation: CLLocationCoordinate2D?
    
    var viewModel: TrackMapViewControllerViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Map"
        setupBackButton(color: .white)
        destinationMarker.map = self.mapView
        destinationMarker.icon = UIImage(named: "helmet_green")
        setupRightBarButtons()
        
        viewModel?.getRiderLastLocation(completion: { (data) in
            print("getting data from closuer yahooo!!!", data)
        })
        
    }
    
    func setupRightBarButtons() {

        let leftChatBtn = UIBarButtonItem(image: UIImage(named: "ic_chat"), style: .plain, target: self, action: #selector(self.openChat))
        leftChatBtn.tintColor = .white
        navigationItem.rightBarButtonItem = leftChatBtn
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.viewModel?.startListeningRiderLocation(completion: { [weak self] coordinate in
            guard let self = self else { return }
            print("getting rider location from view model yahoooooo!!!!!")
            self.updateLocationoordinates(coordinates: coordinate)
            if self.lastUpdatedLocation == nil {
                self.mapView.animate(to: GMSCameraPosition(latitude: coordinate.latitude, longitude: coordinate.longitude, zoom: 19))
            }
            self.lastUpdatedLocation = coordinate
        })
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.viewModel?.stopListen()
    }
    
    @objc func openChat() {
        let sb = UIStoryboard(storyboard: .chat)
        let vc = sb.instantiateViewController(withIdentifier: ChatViewController.storyboardIdentifier) as! ChatViewController
        vc.threadId = self.viewModel?.threadId
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func updateLocationoordinates(coordinates: CLLocationCoordinate2D) {
        CATransaction.begin()
        CATransaction.setAnimationDuration(1.0)
        destinationMarker.position =  coordinates
        CATransaction.commit()
    }

}
