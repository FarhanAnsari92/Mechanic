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
    var jobDetails: BookingHistoryModel?
    
    let locationManager = LocationManager()
    
    private var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "MAP"
        self.setupBackButton(color: .white)
        self.setupCallButton()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.startTimer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.invalidate()
    }
    
    func startTimer() {
        // Invalidate existing timer if there is one
        self.invalidate()
        // Begin a new timer from now
        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true, block: { [weak self] timer in
            self?.handleTimer(timer)
        })
    }
    
    func invalidate() {
        guard let _timer = self.timer else {
            return
        }
        _timer.invalidate()
    }

    private func handleTimer(_ timer: Timer) {
        guard timer.isValid else {
            return
        }
        
        locationManager.getCurrentLocation { (response) in
            switch response {
            case .failure(let error):
                switch error {
                case .authorizationFailed(let strDesc):
                    print(strDesc)
                case .locationUpdationFailed(let strDesc):
                    print(strDesc)
                }
            case .success(let loc):
                print("loc.latitude - ", loc.latitude)
                print("loc.coordinate.latitude - ", loc.coordinate.latitude)
//                self.gmsMapView.animate(to: GMSCameraPosition(latitude: loc.coordinate.latitude, longitude: loc.coordinate.longitude, zoom: 17))
            
                if let job = self.jobDetails,
                   let jobId = job.id,
                   let userId = job.user?.id {
                    var params = [String:Any]()
                    params["job_id"] = jobId.description
                    params["receiver_id"] = userId.description
                    params["latitude"] = loc.coordinate.latitude.description
                    params["longitude"] = loc.coordinate.longitude.description
                    SocketIOManager.shared.emit(.updateRiderLocation, parameters: params)
                }
            }
        }
    }
    
    func setupCallButton() {
        
        let callBtn = UIBarButtonItem(image: UIImage(named: "ic_call"), style: .plain, target: self, action: #selector(self.callButtonHandler))
        callBtn.tintColor = .white

        let chatBtn = UIBarButtonItem(image: UIImage(named: "ic_chat"), style: .plain, target: self, action: #selector(self.openChat))
        chatBtn.tintColor = .white
        navigationItem.rightBarButtonItems = [callBtn, chatBtn]
    }
    
    @objc private func callButtonHandler() {
        print("call")
    }
    
    @objc func openChat() {
        let sb = UIStoryboard(storyboard: .chat)
        let vc = sb.instantiateViewController(withIdentifier: ChatViewController.storyboardIdentifier) as! ChatViewController
        vc.threadId = self.jobDetails?.thread?.threadId?.description
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func reachedDestinationButtonHandler(_ sender: UIButton) {
        let sb = UIStoryboard(storyboard: .dashboard)
        let vc = sb.instantiateViewController(withIdentifier: InspectDetailsViewController.storyboardIdentifier) as! InspectDetailsViewController
        vc.jobDetails = self.jobDetails
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func cancelTaskButtonHandler(_ sender: UIButton) {
        print("cancel")
    }

}
