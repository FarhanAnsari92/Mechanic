//
//  Cart.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 24/10/2021.
//

import Foundation

class Cart {
    
    var vehicle: GetVehicleModel?
    private var services: [Service]?
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
    
    func getServicesIds() -> [String] {
        var ids: [String] = [String]()
        self.services?.forEach({ service in
            if let id = service.id?.description {
                ids.append(id)
            }
        })
        return ids
    }
    
    func set(services: [Service]) {
        self.services = nil
        self.services = services
    }
    
    func getServices() -> [Service]? {
        return self.services
    }
    
}
