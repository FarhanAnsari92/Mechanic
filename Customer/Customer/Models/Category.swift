
import Foundation
import ObjectMapper

class Category : Mappable {
	var currentPage : Int?
	var categories : [CategoryModel]?
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

		currentPage <- map["current_page"]
        categories <- map["data"]
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
