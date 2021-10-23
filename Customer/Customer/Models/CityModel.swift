
import Foundation
import ObjectMapper

class CityModel : Mappable, Equatable {
    
	var id : Int?
	var name : String?
	var status : Bool?
	var createdBy : Int?
	var updatedBy : Int?
	var createdAt : String?
	var updatedAt : String?
	var deletedAt : String?

    init() { }
    
    required init?(map: Map) {

	}

    func mapping(map: Map) {

		id        <- map["id"]
		name      <- map["name"]
		status    <- map["status"]
		createdBy <- map["created_by"]
		updatedBy <- map["updated_by"]
		createdAt <- map["created_at"]
		updatedAt <- map["updated_at"]
		deletedAt <- map["deleted_at"]
	}
    
    static func == (lhs: CityModel, rhs: CityModel) -> Bool {
        return lhs.id == rhs.id
    }

}
