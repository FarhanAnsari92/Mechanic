
import Foundation
import ObjectMapper

class ServiceModel: Mappable {
    
    var services: [Service]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        services <- map["data"]
    }
    
}

class Service : Mappable {
	var id : Int?
	var name : String?
	var description : String?
	var charges : Int?
	var status : Bool?
	var createdBy : Int?
	var updatedBy : Int?
	var createdAt : String?
	var updatedAt : String?
	var deletedAt : String?
    
    var isSelected = false
    

    required init?(map: Map) {

	}

    func mapping(map: Map) {

		id <- map["id"]
		name <- map["name"]
		description <- map["description"]
		charges <- map["charges"]
		status <- map["status"]
		createdBy <- map["created_by"]
		updatedBy <- map["updated_by"]
		createdAt <- map["created_at"]
		updatedAt <- map["updated_at"]
		deletedAt <- map["deleted_at"]
	}

}
