
import Foundation
import ObjectMapper

class OrderResponseModel: Mappable {
	var success : Bool?
	var data : Order?
	var message : String?

    required init?(map: Map) {

    }

    func mapping(map: Map) {

		success <- map["success"]
		data <- map["data"]
		message <- map["message"]
	}

}
