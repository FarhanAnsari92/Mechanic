
import Foundation
import ObjectMapper

class ProductModel: Mappable {
	var id : Int?
	var name : String?
	var description : String?
	var longDescription : String?
	var price : Int?
	var isFeatured : Int?
	var stockAvailable : Int?
	var rating : Double?
	var status : Int?
    var images: [ImageModel]?
	var createdBy : Int?
	var updatedBy : Int?
	var createdAt : String?
	var updatedAt : String?
	var deletedAt : String?
    
    var displayPrice: String {
        let amount = self.price ?? 0
        let amountInt = Helper.formatCurrency(value: amount) ?? "0"
        return "Rs. " + amountInt
    }

	required init?(map: Map) {

	}

	func mapping(map: Map) {

		id <- map["id"]
		name <- map["name"]
		description <- map["description"]
		longDescription <- map["long_description"]
		price <- map["price"]
		isFeatured <- map["is_featured"]
		stockAvailable <- map["stock_available"]
		rating <- map["rating"]
		status <- map["status"]
        images <- map["images"]
		createdBy <- map["created_by"]
		updatedBy <- map["updated_by"]
		createdAt <- map["created_at"]
		updatedAt <- map["updated_at"]
		deletedAt <- map["deleted_at"]
	}

}
