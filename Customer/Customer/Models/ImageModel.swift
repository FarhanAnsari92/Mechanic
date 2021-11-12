
import Foundation
import ObjectMapper

class ImageModel : Mappable {
	var id : Int?
	var entityType : String?
	var entityId : Int?
	var mediaType : String?
	var media : String?
	var createdBy : String?
	var status : Int?
	var createdAt : String?
	var updatedAt : String?
	var deletedAt : String?
	var mediaUrl : String?
    
    var url: URL? {
        get {
            if let strURL = mediaUrl {
                if let url = URL(string: strURL) {
                    return url
                }
            }
            return nil
        }
    }

	required init?(map: Map) {

	}

    func mapping(map: Map) {

		id <- map["id"]
		entityType <- map["entity_type"]
		entityId <- map["entity_id"]
		mediaType <- map["media_type"]
		media <- map["media"]
		createdBy <- map["created_by"]
		status <- map["status"]
		createdAt <- map["created_at"]
		updatedAt <- map["updated_at"]
		deletedAt <- map["deleted_at"]
		mediaUrl <- map["media_url"]
	}

}
