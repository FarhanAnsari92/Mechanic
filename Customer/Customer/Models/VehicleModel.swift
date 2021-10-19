//
//  VehicleModel.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 19/10/2021.
//

import ObjectMapper

class VehicleModel: Mappable, Equatable {
    var id        : Int?
    var brand_id  : Int?
    var name      : String?
    var status    : Bool?
    var createdBy : Int?
    var updatedBy : Int?
    var createdAt : String?
    var updatedAt : String?
    
    init() { }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id        <- map["id"]
        brand_id  <- map["brand_id"]
        name      <- map["name"]
        status    <- map["status"]
        createdBy <- map["created_by"]
        updatedBy <- map["updated_by"]
        createdAt <- map["created_at"]
        updatedAt <- map["updated_at"]
        
    }
    
    static func == (lhs: VehicleModel, rhs: VehicleModel) -> Bool {
        return lhs.id == rhs.id
    }
    
}
