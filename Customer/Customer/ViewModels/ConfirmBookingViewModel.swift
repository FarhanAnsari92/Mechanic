//
//  ConfirmBookingViewModel.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 24/10/2021.
//

import Foundation

class ConfirmBookingViewModel {
    
    func getData() -> [Section]? {
        var data: [Section] = [Section]()
        
        let vehicel = Cart.shared.vehicle
        
        //---------- Vehicles Details
        
        let vehicleDetails = Section(
            title: "Vehicle Details",
            details: [
                LeftRight(leftTitle: "Brand:", rightTitle: vehicel?.brand?.title ?? "N/A"),
                LeftRight(leftTitle: "House Power:", rightTitle: vehicel?.horsePower ?? "N/A"),
                LeftRight(leftTitle: "Year:", rightTitle: vehicel?.year?.description ?? "N/A"),
                LeftRight(leftTitle: "City:", rightTitle: vehicel?.city?.name ?? "N/A")
            ]
        )
        data.append(vehicleDetails)
        
        //---------- Selected Services Section
        
        var lrService = [LeftRight]()
        var total = 0
        Cart.shared.services?.forEach({ service in
            total += service.charges ?? 0
            let charges = service.charges ?? 0
            let formattedCharge = Helper.formatCurrency(value: charges)
            lrService.append(LeftRight(leftTitle: service.name ?? "", rightTitle: "Rs. " + (formattedCharge ?? charges.description)))
        })
        let totalFormattedCharges = Helper.formatCurrency(value: total)
        lrService.append(LeftRight(leftTitle: "Total Amount", rightTitle: "Rs. " + (totalFormattedCharges ?? total.description), hideTopSeparator: false, hideBottomSeparator: false))
        
        let servicesDetails = Section(
            title: "Selected Services",
            details: lrService
        )
        
        data.append(servicesDetails)
        
        //---------- Selected Mode
                
        var lrMode = [LeftRight]()
        if AppDelegate.instance.isPickupSelected {
            lrMode.append(LeftRight(leftTitle: "Pickup From My Location", rightTitle: ""))
            lrMode.append(LeftRight(leftTitle: "Address", rightTitle: Cart.shared.address?.address ?? ""))
            lrMode.append(LeftRight(leftTitle: "Estimated Arrving Time", rightTitle: "45Mins"))
        } else {
            lrMode.append(LeftRight(leftTitle: "Drop to Workshop By Myself", rightTitle: ""))
            lrMode.append(LeftRight(leftTitle: "Date", rightTitle: "2 Sep 2021"))
            lrMode.append(LeftRight(leftTitle: "Time Slot", rightTitle: "09:00 PM"))
        }
        
        let serviceModeDetails = Section(
            title: "Service Mode",
            details: lrMode
        )
        data.append(serviceModeDetails)
        
        //---------- Payment Method
        
        let paymentMethod = Section(
            title: "Payment Method",
            details: [
                LeftRight(leftTitle: "", rightTitle: "")
            ]
        )
        data.append(paymentMethod)
        
        return data
    }
    
}
