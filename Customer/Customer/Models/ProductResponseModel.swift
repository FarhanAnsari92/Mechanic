
import Foundation
import ObjectMapper

class ProductResponseModel: Mappable {
    
	var success : Bool?
	var data : ProductBaseModel?
	var message : String?

	required init?(map: Map) {

	}

    func mapping(map: Map) {

		success <- map["success"]
		data <- map["data"]
		message <- map["message"]
	}

}
