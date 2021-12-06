//
//  InspectionModel.swift
//  Mechanic
//
//  Created by BYKEA - Hadi Ali on 07/12/2021.
//

import ObjectMapper

class InspectionResponseModel: Mappable {
    
    var success : Bool?
    var data : [InspectionModel]?
    var message : String?
    
    required init?(map: Map) {

    }

    func mapping(map: Map) {
        success <- map["success"]
        data <- map["data"]
        message <- map["message"]
    }
}

class InspectionModel: Mappable {
    
    var id : Int?
    var title : String?
    var status : Int?
    var createdBy : Int?
    var updatedBy : Int?
    var createdAt : String?
    var updatedAt : String?
    var deletedAt : String?

    required init?(map: Map) {

    }

    func mapping(map: Map) {

        id <- map["id"]
        title <- map["title"]
        status <- map["status"]
        createdBy <- map["created_by"]
        updatedBy <- map["updated_by"]
        createdAt <- map["created_at"]
        updatedAt <- map["updated_at"]
        deletedAt <- map["deleted_at"]
    }
}
