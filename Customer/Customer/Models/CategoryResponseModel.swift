
import Foundation
import ObjectMapper

class CategoryResponseModel : Mappable {
	var success : Bool?
	var category : Category?
	var message : String?

	required init?(map: Map) {

	}

	func mapping(map: Map) {

		success <- map["success"]
        category <- map["data"]
		message <- map["message"]
	}

}
