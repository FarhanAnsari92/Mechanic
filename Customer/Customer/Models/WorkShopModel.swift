//
//  WorkShopModel.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 23/10/2021.
//

import Foundation
import ObjectMapper

class WorkShopResponseModel: Mappable {
    
    var success: Bool?
    var workshops: [WorkShopModel]?
    var message: String?
    
    required init?(map: Map) {

    }

    func mapping(map: Map) {
        success <- map["success"]
        workshops <- map["data"]
        message <- map["message"]
    }
    
}

class WorkShopModel: Mappable {
    var id : Int?
    var name : String?
    var address : String?
    var city_id : Int?
    var latitude : Double?
    var longitude : Double?
    var status : Bool?
    var work_start_time : String?
    var work_end_time : String?
    var created_by : Int?
    var updated_by : Int?
    var created_at : String?
    var updated_at : String?
    var deleted_at : String?
    var city : String?
    
    var isSelected: Bool = false

    required init?(map: Map) {

    }

    func mapping(map: Map) {

        id <- map["id"]
        name <- map["name"]
        address <- map["address"]
        city_id <- map["city_id"]
        latitude <- map["latitude"]
        longitude <- map["longitude"]
        status <- map["status"]
        work_start_time <- map["work_start_time"]
        work_end_time <- map["work_end_time"]
        created_by <- map["created_by"]
        updated_by <- map["updated_by"]
        created_at <- map["created_at"]
        updated_at <- map["updated_at"]
        deleted_at <- map["deleted_at"]
        city <- map["city"]
    }

}

