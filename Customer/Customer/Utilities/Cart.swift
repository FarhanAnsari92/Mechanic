//
//  Cart.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 24/10/2021.
//

import Foundation

class Cart {
    
    var vehicle: GetVehicleModel?
    var services: [Service]?
    var address: AddressModel?
    
    private init() {
        
    }
    
    static let shared: Cart = Cart()
    
    func getTotalAmount() -> Int {
        var total = 0
        self.services?.forEach({ service in
            if service.isSelected {
                total += service.charges ?? 0
            }
        })
        return total
    }
    
}
