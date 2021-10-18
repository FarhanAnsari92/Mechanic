//
//  BrandModel.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 19/10/2021.
//

import ObjectMapper

class BrandModel: Mappable, Equatable {
    
    var id        : Int?
    var title     : String?
    var status    : Bool?
    var createdBy : Int?
    var updatedBy : Int?
    var createdAt : String?
    var updatedAt : String?
    var deletedAt : String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id        <- map["id"]
        title     <- map["title"]
        status    <- map["status"]
        createdBy <- map["created_by"]
        updatedBy <- map["updated_by"]
        createdAt <- map["created_at"]
        updatedAt <- map["updated_at"]
        deletedAt <- map["deleted_at"]
    }
    
    static func == (lhs: BrandModel, rhs: BrandModel) -> Bool {
        return lhs.id == rhs.id
    }
    
}
