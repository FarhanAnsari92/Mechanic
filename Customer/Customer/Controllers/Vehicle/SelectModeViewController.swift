//
//  SelectModeViewController.swift
//  Customer
//
//  Created by Mohammad Farhan on 10/8/21.
//

import UIKit

class SelectModeViewController: HomeBaseViewController {
    
    @IBOutlet weak var pickupShadowView: ShadowView! {
        didSet {
            pickupShadowView.layer.borderColor = UIColor.Theme.green.cgColor
        }
    }
    @IBOutlet weak var workshopShadowView: ShadowView! {
        didSet {
            workshopShadowView.layer.borderColor = UIColor.Theme.green.cgColor
        }
    }
    @IBOutlet weak var btn_pickup:   UIButton!
    @IBOutlet weak var btn_workshop: UIButton!
    @IBOutlet weak var radio_pickup: AppRadioView!
    @IBOutlet weak var radio_workshop: AppRadioView!
    @IBOutlet weak var timeSlotView: UIView!
    
    
    @IBOutlet weak var dateview: UIView!{
        didSet{
            
            dateview.layer.cornerRadius = 10
            dateview.layer.borderColor = UIColor(hexString: "BEC5D1").cgColor
            dateview.layer.borderWidth = 1
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Select Mode"
        setupBackButton(color: .white)
        setPickup(show: true)
        

        
    }
    
    @IBAction func btn_proceed(_ sender: UIButton) {
        if AppDelegate.instance.isPickupSelected {
            let sb = UIStoryboard(storyboard: .address)
            let vc = sb.instantiateViewController(withIdentifier: AddressListViewController.storyboardIdentifier)
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let sb = UIStoryboard(storyboard: .vehicle)
            let vc = sb.instantiateViewController(withIdentifier: SelectWorkshopViewController.storyboardIdentifier)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func btn_pickupLocation(_ sender: UIButton){
        
        setPickup(show: true)
    }
    
    @IBAction func btn_workshop(_ sender: UIButton){
        setPickup(show: false)
    }

    func setPickup(show: Bool) {
        radio_pickup.isHidden = !show
        timeSlotView.isHidden = show
        radio_workshop.isHidden = show
        if show {
            pickupShadowView.layer.borderWidth = 1
            workshopShadowView.layer.borderWidth = 0
            AppDelegate.instance.isPickupSelected = true
        } else {
            pickupShadowView.layer.borderWidth = 0
            workshopShadowView.layer.borderWidth = 1
            AppDelegate.instance.isPickupSelected = false
        }
        
        
    }
}
