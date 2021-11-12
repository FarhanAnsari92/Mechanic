
import Foundation
import ObjectMapper

class ProductBaseModel: Mappable {
	var current_page : Int?
	var products : [ProductModel]?
	var firstPageUrl : String?
	var from : Int?
	var lastPage : Int?
	var lastPageUrl : String?
	var nextPageUrl : String?
	var path : String?
	var perPage : Int?
	var prevPageUrl : String?
	var to : Int?
	var total : Int?

	required init?(map: Map) {

	}

	func mapping(map: Map) {

		current_page <- map["current_page"]
        products <- map["data"]
		firstPageUrl <- map["first_page_url"]
		from <- map["from"]
		lastPage <- map["last_page"]
		lastPageUrl <- map["last_page_url"]
		nextPageUrl <- map["next_page_url"]
		path <- map["path"]
		perPage <- map["per_page"]
		prevPageUrl <- map["prev_page_url"]
		to <- map["to"]
		total <- map["total"]
	}

}
