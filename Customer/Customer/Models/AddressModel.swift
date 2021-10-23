//
//  AddressModel.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 23/10/2021.
//

import ObjectMapper

class AddressResponseModel: Mappable {
    
    var message: String?
    var addressesModel: AddressesModel?
    var address: AddressModel?
    var success: Bool?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        message <- map["message"]
        addressesModel <- map["data"]
        address <- map["data"]
        success <- map["success"]
    }
}

class AddressesModel: Mappable {
    
    var addresses: [AddressModel]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        addresses <- map["data"]
    }
}

class AddressModel: Mappable {
    
    var address: String?
    var cityId: Int?
    var createdAt: String?
    var id: Int?
    var isDefault: Bool?
    var latitude: String?
    var longitude: String?
    var status: Int?
    var street: Int?
    var title: String?
    var updatedAt: String?
    var userId: Int?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        address <- map["address"]
        cityId <- map["city_id"]
        createdAt <- map["created_at"]
        id <- map["id"]
        isDefault <- map["is_default"]
        latitude <- map["latitude"]
        longitude <- map["longitude"]
        status <- map["status"]
        street <- map["street"]
        title <- map["title"]
        updatedAt <- map["updated_at"]
        userId <- map["user_id"]
    }
}
