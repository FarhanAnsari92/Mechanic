//
//  UserModel.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 17/10/2021.
//

import ObjectMapper
import UIKit

class UserObjectModel: Mappable {
    var user: UserModel?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        user <- map["user"]
    }
}

class UserModel: NSObject, Mappable {
    
    var id: Int?
    var accessToken: String?
    var details: UserDetailsModel?
    var email: String?
    var mobileNumber: String?
    var name: String?
    var role: [RoleMode]?
    var tokenType: String?
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        accessToken  <- map["access_token"]
        details      <- map["details"]
        email        <- map["email"]
        id           <- map["id"]
        mobileNumber <- map["mobile_no"]
        name         <- map["name"]
        role         <- map["roles"]
        tokenType    <- map["token_type"]
    }
    
    
    
}
