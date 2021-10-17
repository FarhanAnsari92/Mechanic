//
//  RegistrationDataModel.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 17/10/2021.
//

import Foundation
import ObjectMapper

class RegistrationDataModel: Mappable {
    
    var data: UserObjectModel?
    var message: String?
    var success: Bool?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        data    <- map["data"]
        message <- map["message"]
        success <- map["success"]
    }
    
}
