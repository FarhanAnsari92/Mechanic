//
//  MapViewController.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 25/01/2022.
//

import UIKit
import GoogleMaps

class TrackMapViewController: HomeBaseViewController {
    
    @IBOutlet weak var mapView: GMSMapView! {
        didSet {
            mapView.animate(toZoom: 18)
        }
    }
    
    let destinationMarker = GMSMarker()
    var lastUpdatedLocation: CLLocationCoordinate2D?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Map"
        setupBackButton(color: .white)
        destinationMarker.map = self.mapView
        destinationMarker.icon = UIImage(named: "helmet_green")
        if let userId = Helper.getUser()?.id {
            print("userId - ", userId)
//            SocketIOManager.shared.emit(.getUserThreads, parameters: [:])
            SocketIOManager.shared.emit(.getRiderLastLocation, parameters: [:])
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        SocketIOManager.shared.on(.notifyUserNewRiderLocation) { (data, ack) in            
            if let arr = data as? [[String:Any]],
               let firstObj = arr.first,
               let rawData = firstObj["data"] as? [String:Any],
               let strLatitude = rawData["latitude"] as? String,
               let strLongitude = rawData["longitude"] as? String,
               let latitude = Double(strLatitude),
               let longitude = Double(strLongitude) {
                let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                self.updateLocationoordinates(coordinates: coordinate)
                if self.lastUpdatedLocation == nil {
                    self.mapView.animate(to: GMSCameraPosition(latitude: coordinate.latitude, longitude: coordinate.longitude, zoom: 19))
                }
                self.lastUpdatedLocation = coordinate
            }
        }
        
        SocketIOManager.shared.on(.riderLocationSuccess) { (data, ack) in
            print("socket event data - ", data)
            print("socket event ack - ", ack)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        SocketIOManager.shared.off(.notifyUserNewRiderLocation)
        SocketIOManager.shared.off(.riderLocationSuccess)
    }
    
    func updateLocationoordinates(coordinates: CLLocationCoordinate2D) {
        CATransaction.begin()
        CATransaction.setAnimationDuration(1.0)
        destinationMarker.position =  coordinates
        CATransaction.commit()
    }

}
