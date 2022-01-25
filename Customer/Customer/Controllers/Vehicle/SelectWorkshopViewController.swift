//
//  SelectWorkshopViewController.swift
//  Customer
//
//  Created by Mohammad Farhan on 10/10/21.
//

import UIKit
import GoogleMaps

class SelectWorkshopViewController: HomeBaseViewController {
    
    @IBOutlet weak var btn_done: UIButton!
    @IBOutlet weak var tableview: UITableView!{
        didSet{
            tableview.delegate = self
            tableview.dataSource = self
            tableview.register(SelectWorkshopTableViewCell.nib, forCellReuseIdentifier: SelectWorkshopTableViewCell.identifier)
        }
    }
    @IBOutlet weak var gmsMapView: GMSMapView! {
        didSet {
            gmsMapView.layer.cornerRadius = 15
            gmsMapView.animate(toZoom: 18)
        }
    }
    
    var workshops: [WorkShopModel]?
    var selectedWorkshop: WorkShopModel?

    let locationManager = LocationManager(withAccuracy: .bestForNavigation)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Select Workshop"
        setupBackButton(color: .white)
        getWorkshops()
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
    
    func getWorkshops() {
        APIClient.callApi(api: .workShops, parameters: nil, method: .get, view: self.view) { [weak self] data in
            
            if let dictionary = data, let workShopResponseModel = ObjectMapperManager<WorkShopResponseModel>().map(dictionary: dictionary) {
                print("ObjectMapperManager - ", workShopResponseModel.toJSON())
                self?.workshops = workShopResponseModel.workshops
                self?.tableview.reloadData()
            }
        }
    }
    
    @IBAction func btn_done(_ sender: UIButton) {
        let sb = UIStoryboard(storyboard: .vehicle)
        let vc = sb.instantiateViewController(withIdentifier: ConfirmBookingViewController.storyboardIdentifier) as! ConfirmBookingViewController
        vc.selectedWorkshop = self.selectedWorkshop
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension SelectWorkshopViewController : UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workshops?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SelectWorkshopTableViewCell.identifier, for: indexPath) as!
            SelectWorkshopTableViewCell
        if let workshop = self.workshops?[indexPath.row] {
            cell.set(data: workshop)
        }
//        if indexPath.row == 1 {
//            cell.isSelected = false
//
//        } else {
//            cell.isSelected = true
//        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard !(self.workshops?[indexPath.row].isSelected ?? false) else {            
            return
        }
        self.workshops?.forEach({ $0.isSelected = false })
        self.workshops?[indexPath.row].isSelected = true
        self.selectedWorkshop = self.workshops?[indexPath.row]
        self.tableview.reloadSections(IndexSet(integer: 0), with: .fade)
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let vu = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width / 2, height: 35))
        vu.backgroundColor = .white
        let lbl = UILabel(frame: CGRect(x: 20, y: 0, width: self.view.frame.width / 2, height: 35))
        lbl.text = "Near By"
        lbl.font = UIFont.Poppins(.semiBold, size: 18)
        vu.addSubview(lbl)
        return vu
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
}
