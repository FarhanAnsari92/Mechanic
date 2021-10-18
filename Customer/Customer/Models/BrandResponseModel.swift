//
//  BrandResponseModel.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 19/10/2021.
//

import ObjectMapper

class BrandResponseModel: Mappable {
    
    var success : Bool?
    var brands : [BrandModel]?
    var message : String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        brands  <- map["data"]
        message <- map["message"]
    }    
    
}
