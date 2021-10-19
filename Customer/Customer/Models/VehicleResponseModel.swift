//
//  VehicleResponseModel.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 19/10/2021.
//

import ObjectMapper

class VehicleResponseModel : Mappable {
    
    var success : Bool?
    var models : [VehicleModel]?
    var message : String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        success <- map["success"]
        models  <- map["data"]
        message <- map["message"]
    }
    
    
}
