//
//  RoleModel.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 17/10/2021.
//

import ObjectMapper
import UIKit


class RoleMode: Mappable {
    
    var Id: Int?
    var description: String?
    var dispalyName: String?
    var isProtected: Bool?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        description <- map["description"]
        dispalyName <- map["display_name"]
        Id          <- map["id"]
        isProtected <- map["is_protected"]
        
    }
    
    
}
