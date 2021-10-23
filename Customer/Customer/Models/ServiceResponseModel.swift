
import Foundation
import ObjectMapper

class ServiceResponseModel : Mappable {
	var success : Bool?
	var service : ServiceModel?
	var message : String?

    required init?(map: Map) {

	}

    func mapping(map: Map) {

		success <- map["success"]
		service <- map["data"]
		message <- map["message"]
	}

}
