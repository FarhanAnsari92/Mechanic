
import Foundation
import ObjectMapper

class GetVehicleResponseModel: Mappable {
	var success : Bool?
	var vehicleData : GetVehicleResponseDataModel?
	var message : String?

    required init?(map: Map) {

	}

    func mapping(map: Map) {

		success     <- map["success"]
        vehicleData <- map["data"]
		message     <- map["message"]
	}

}
