
import Foundation
import ObjectMapper

class CategoryModel : Mappable {
	var id : Int?
	var name : String?
	var description : String?
	var icon : String?
	var status : Int?
	var image : String?
	var createdBy : Int?
	var updatedBy : Int?
	var createdAt : String?
	var updatedAt : String?
	var deletedAt : String?
	var iconUrl : String?

	required init?(map: Map) {

	}

	func mapping(map: Map) {

		id <- map["id"]
		name <- map["name"]
		description <- map["description"]
		icon <- map["icon"]
		status <- map["status"]
		image <- map["image"]
		createdBy <- map["created_by"]
		updatedBy <- map["updated_by"]
		createdAt <- map["created_at"]
		updatedAt <- map["updated_at"]
		deletedAt <- map["deleted_at"]
		iconUrl <- map["icon_url"]
	}

}
