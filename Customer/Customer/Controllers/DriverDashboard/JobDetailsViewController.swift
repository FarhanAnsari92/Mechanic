//
//  JobDetailsViewController.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 02/12/2021.
//

import UIKit
import GoogleMaps

class JobDetailsViewController: UIViewController {
   
    @IBOutlet weak var gmsMapView: GMSMapView! {
        didSet {
            gmsMapView.layer.cornerRadius = 15
            gmsMapView.clipsToBounds = true
            gmsMapView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var jobDetails: BookingHistoryModel?
    
    var data: [Section] = [Section]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Task Details"
        self.setupBackButton(color: .white)

        self.setData()
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
    
    @objc func pickuopNowButtonHandler(_ sender: UIButton) {
                
        if let _id = jobDetails?.id {
            
            let id = _id.description
            
            var dataToUpdate = [String:String]()
            dataToUpdate["job_status"] = "pick_up"
            
            APIClient.callApi(api: .job, parameters: dataToUpdate, id: id, method: .put, view: self.view) { (dictionary) in
                
                if dictionary?["success"] as? Bool ?? false {
                    
                    let sb = UIStoryboard(storyboard: .dashboard)
                    let vc = sb.instantiateViewController(withIdentifier: MapViewController.storyboardIdentifier) as! MapViewController
                    vc.jobDetails = self.jobDetails
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                }
            }
        }
                                
    }

}

// MARK: View Setup

extension JobDetailsViewController {
    
    func setData() {
        guard let job = self.jobDetails else {
            return
        }
        self.setupVehicleDetails(job: job)
        self.setupCustomerDetails(job: job)
        self.setupPickupNowButton()
        
    }
    
    private func setupVehicleDetails(job: BookingHistoryModel) {
        var vehiclelr = [LeftRight]()
        
        vehiclelr.append(LeftRight(leftTitle: "Number Plate", rightTitle: job.vehicleName))
        
        vehiclelr.append(LeftRight(leftTitle: "Brand", rightTitle: job.brandName))
        
        vehiclelr.append(LeftRight(leftTitle: "Horse Power", rightTitle: job.horsePower))
        
        vehiclelr.append(LeftRight(leftTitle: "Year", rightTitle: job.year))
        
        vehiclelr.append(LeftRight(leftTitle: "City", rightTitle: job.cityName))
        let vehicleDetailsContainer = KeyValueViewContainer()
        vehicleDetailsContainer.btnChange.isHidden = true
        vehicleDetailsContainer.setData(section: Section(title: "Vehicle Details", details: vehiclelr))
        
        self.stackView.addArrangedSubview(vehicleDetailsContainer)
    }
    
    private func setupCustomerDetails(job: BookingHistoryModel) {
        let userName = job.user?.name ?? "NA"
        let mobileNumber = job.user?.mobileNumber ?? "NA"
        let address = job.user?.details?.address ?? "NA"
        
        var customerDetailslr = [LeftRight]()
        customerDetailslr.append(LeftRight(leftTitle: "Name", rightTitle: userName))
        customerDetailslr.append(LeftRight(leftTitle: "Mobile Number", rightTitle: mobileNumber))
        customerDetailslr.append(LeftRight(leftTitle: "Address", rightTitle: address))
        
        let customerDetailsContainer = KeyValueViewContainer()
        customerDetailsContainer.btnChange.isHidden = true
        customerDetailsContainer.setData(section: Section(title: "Customer Details", details: customerDetailslr))
        
        self.stackView.addArrangedSubview(customerDetailsContainer)
    }
    
    private func setupPickupNowButton() {
        let pickupBtn = AppButton(frame: CGRect(origin: .zero, size: CGSize(width: self.stackView.frame.width, height: 55)))
        pickupBtn.translatesAutoresizingMaskIntoConstraints = false
        pickupBtn.heightAnchor.constraint(equalToConstant: 55).isActive = true
        pickupBtn.setTitle("PICK UP NOW", for: .normal)
        pickupBtn.addTarget(self, action: #selector(self.pickuopNowButtonHandler(_:)), for: .touchUpInside)
        self.stackView.addArrangedSubview(pickupBtn)
    }

}
