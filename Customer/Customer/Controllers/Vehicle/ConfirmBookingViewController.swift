//
//  ConfirmBookingViewController.swift
//  Customer
//
//  Created by Mohammad Farhan on 10/10/21.
//

import UIKit

struct Section {
    var title: String
    var details: [LeftRight]
}

struct LeftRight {
    var leftTitle: String
    var rightTitle: String
    var hideTopSeparator: Bool
    var hideBottomSeparator: Bool
    
    init(leftTitle: String, rightTitle: String, hideTopSeparator: Bool = true, hideBottomSeparator: Bool = true) {
        self.leftTitle = leftTitle
        self.rightTitle = rightTitle
        self.hideTopSeparator = hideTopSeparator
        self.hideBottomSeparator = hideBottomSeparator
    }
}

class ConfirmBookingViewController: HomeBaseViewController {
    
    @IBOutlet weak var tableview: UITableView! {
        didSet {
            tableview.delegate = self
            tableview.dataSource = self
            tableview.register(ConfirmBookingTableViewCell.nib, forCellReuseIdentifier: ConfirmBookingTableViewCell.identifier)
            tableview.register(BuyAccessoriesConfirmationPaymentMethodTableViewCell.nib, forCellReuseIdentifier: BuyAccessoriesConfirmationPaymentMethodTableViewCell.identifier)
        }
    }
    
    var data: [Section] = [Section]()
    let viewModel = ConfirmBookingViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Confirm Booking"
        setupBackButton(color: .white)
//        self.setData()
        if let d = viewModel.getData() {
            self.data = d
        }
    }
    
    func setData() {
        let vehicleDetails = Section(
            title: "Vehicle Details",
            details: [
                LeftRight(leftTitle: "Brand:", rightTitle: "Honda"),
                LeftRight(leftTitle: "House Power:", rightTitle: "125CC"),
                LeftRight(leftTitle: "Year:", rightTitle: "2021"),
                LeftRight(leftTitle: "City:", rightTitle: "Karachi")
            ]
        )
        data.append(vehicleDetails)
        
        let servicesDetails = Section(
            title: "Selected Services",
            details: [
                LeftRight(leftTitle: "Oil Changing", rightTitle: "Rs. 300"),
                LeftRight(leftTitle: "Wash & Service", rightTitle: "Rs. 400"),
                LeftRight(leftTitle: "Tunning", rightTitle: "Rs. 2,000"),
                LeftRight(leftTitle: "Total Amount", rightTitle: "Rs. 2,700", hideTopSeparator: false, hideBottomSeparator: false)
            ]
        )
        data.append(servicesDetails)
        
        let serviceModeDetails = Section(
            title: "Service Mode",
            details: [
                LeftRight(leftTitle: "Drop to Workshop By Myself", rightTitle: ""),
                LeftRight(leftTitle: "Date", rightTitle: "2 Sep 2021"),
                LeftRight(leftTitle: "Time Slot", rightTitle: "09:00 PM")
            ]
        )
        data.append(serviceModeDetails)
        
        let paymentMethod = Section(
            title: "Payment Method",
            details: [
                LeftRight(leftTitle: "", rightTitle: "")
            ]
        )
        data.append(paymentMethod)
    }
    
    @IBAction func confirmButtonHandler(_ sender: UIButton) {
        self.requestJob()
    }
    
    func requestJob() {
        let cart = Cart.shared
        var params = [String:String]()
        
        params["user_id"] = cart.vehicle?.userId?.description ?? "0" //?.description ?? ""
//        params["rider_id"] = "0" // not used
        params["job_type"] = AppDelegate.instance.isPickupSelected ? "pick" : "drop"
//        params["job_status"] = "" // not used
        params["vehicle_id"] = cart.vehicle?.id?.description ?? "0" //.description ?? ""
        params["brand_id"] = cart.vehicle?.brand?.id?.description ?? ""
        params["model_id"] = cart.vehicle?.vehicle?.id?.description ?? ""
        params["number_plate"] = cart.vehicle?.numberPlate ?? ""
        params["horse_power"] = cart.vehicle?.horsePower ?? ""
        params["year"] = cart.vehicle?.year?.description ?? ""
        params["address"] = cart.address?.address ?? ""
        params["city_id"] = cart.vehicle?.city?.id?.description ?? ""
        params["latitude"] = cart.address?.latitude?.description ?? ""
        params["longitude"] = cart.address?.longitude?.description ?? ""
        params["total_amount"] = cart.getTotalAmount().description
        params["payment_type"] = "creditcard"
        params["drop_date"] = "2021-11-26"
        params["drop_time"] = "11:11"
        for i in 0..<(cart.getServices()?.count ?? 0) {
            if let id = cart.getServices()?[i].id {
                params["services[\(i)]"] = id.description
            }
        }
        
        print("params --- ", params)
        
        APIClient.callApi(api: .job, parameters: params, method: .post, data: nil, view: self.view) { [weak self] data in
            
            let sb = UIStoryboard(storyboard: .vehicle)
            if AppDelegate.instance.isPickupSelected {
                let vc = sb.instantiateViewController(withIdentifier: SuccessfullRiderViewController.storyboardIdentifier)
                self?.navigationController?.pushViewController(vc, animated: true)
            } else {
                let vc = sb.instantiateViewController(withIdentifier: SuccessfullViewController.storyboardIdentifier)
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            
        }
        
    }
}

extension ConfirmBookingViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = data[indexPath.row]
        if item.title == "Payment Method" {
            let cell = tableView.dequeueReusableCell(withIdentifier: BuyAccessoriesConfirmationPaymentMethodTableViewCell.identifier, for: indexPath)
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ConfirmBookingTableViewCell.identifier, for: indexPath) as! ConfirmBookingTableViewCell
        cell.setData(section: item)
        cell.changeCompletion = { [weak self] in
            if indexPath.row == 0 {
                if let myVehicle = self?.navigationController?.viewControllers.first(where: { $0 is MyVehicleViewController }) {
                    self?.navigationController?.popToViewController(myVehicle, animated: true)
                }
            } else if indexPath.row == 1 {
                if let selectService = self?.navigationController?.viewControllers.first(where: { $0 is SelectServicesViewController }) {
                    self?.navigationController?.popToViewController(selectService, animated: true)
                }
            } else if indexPath.row == 2 {
                if let selectMode = self?.navigationController?.viewControllers.first(where: { $0 is SelectModeViewController }) {
                    self?.navigationController?.popToViewController(selectMode, animated: true)
                }
            }
        }
        return cell
    }
    
}

class BookingRequestModel: Mappable {

    var userId: String?
    var jobType: String?
    var vehicleId: String?
    var brandId: String?
    var modelId: String?
    var numberPlate: String?
    var horsePower: String?
    var year: String?
    var cityId: String?
    var latitude: String?
    var longitude: String?
    var totalAmount: String?
    var paymentType: String?
    var services: [Int]?
    var dropDate: String?
    var dropTime: String?
    

    required init?(map: Map) {

    }

    func mapping(map: Map) {
        userId <- map ["user_id"]
        jobType <- map ["job_type"]
        vehicleId <- map  ["vehicle_id"]
        brandId <- map ["brand_id"]
        modelId <- map ["model_id"]
        numberPlate <- map ["number_plate"]
        horsePower <- map ["horse_power"]
        year <- map ["year"]
        cityId <- map ["address"]
        latitude <- map ["city_id"]
        longitude <- map ["latitude"]
        totalAmount <- map ["longitude"]
        paymentType <- map ["total_amount"]
        services <- map ["payment_type"]
        dropDate <- map ["services"]
        dropTime <- map ["drop_date"]
        userId <- map["drop_time"]
    }

}
