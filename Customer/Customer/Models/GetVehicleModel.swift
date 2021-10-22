
import Foundation
import ObjectMapper

class GetVehicleResponseDataModel: Mappable {
    var data: [GetVehicleModel]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        data <- map["data"]
    }
}

class GetVehicleModel : Mappable {
	
    var brand: BrandModel?
    var city: CityModel?
    var vehicle: VehicleModel?
    var horsePower: String?
    var year: Int?

    required init?(map: Map) {

	}

    func mapping(map: Map) {

        brand       <- map["brand"]
        city        <- map["city"]
        vehicle     <- map["vehicle_model"]
        horsePower  <- map["horse_power"]
        year        <- map["year"]
		
	}

}
