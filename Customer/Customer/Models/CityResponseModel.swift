
import Foundation
import ObjectMapper

class CityResponseModel: Mappable {
	var success : Bool?
	var data : [CityModel]?
	var message : String?

    required init?(map: Map) {

	}

	func mapping(map: Map) {

		success <- map["success"]
		data <- map["data"]
		message <- map["message"]
	}

}
