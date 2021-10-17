//
//  UserDetailsModel.swift
//  Customer
//
//  Created by BYKEA - Hadi Ali on 17/10/2021.
//

import ObjectMapper
import UIKit



class UserDetailsModel: Mappable {
    
    var id: Int?
    var firstName: String?
    var lastName: String?
    var emailUpdate: String?
    var cnic: String?
    var address: String?
    var image: String?
    var imageURlStr: String?
    var isSocialLogin: Bool?
    var isVerified: Bool?
    
    var phone: String?
    
    required init?(map: Map) {
        
    }    
    
    func mapping(map: Map) {
        address         <- map["address"]
        cnic            <- map["cnic"]
        emailUpdate     <- map["email_updates"]
        firstName       <- map["first_name"]
        id              <- map["id"]
        image           <- map["image"]
        imageURlStr     <- map["image_url"]
        isSocialLogin   <- map["is_social_login"]
        isVerified      <- map["is_verified"]
        lastName        <- map["last_name"]
        phone           <- map["phone"]
    }
    
    
}
